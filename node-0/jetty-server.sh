#!/bin/bash

#---------------------------------------
STOPPORT="9090"
PROCESS="jetty:deploy-war"
PIDFILE="/tmp/jetty-server-$STOPPORT.pid"
LOGFILE="/tmp/jetty-server-$STOPPORT.log"
HTTPPORT="8080"

#---------------------------------------
# print help message
function show_help() {
  echo "usage: ./$(basename $BASH_SOURCE) start|stop|restart|status|console"
  exit 1
}

# initialize files
function initFiles(){
 if [ ! -f "${PIDFILE}" ] ; then
   resetFiles
 else
    PID=$(cat ${PIDFILE})
    if ! isRunning "$STOPPORT"; then
        resetFiles
    fi
 fi
}

# reset files
function resetFiles(){
  echo 0 > ${PIDFILE}
  [ -f "${LOGFILE}" ] && rm ${LOGFILE}
}

# start
function startService(){
 PID=$(cat ${PIDFILE})
 if [ "$PID" == 0 ] || [ -z "$PID" ] ; then
    # start process
    cp -f resources/pom_deploy-war.xml ./pom.xml &&
    nohup mvn jetty:deploy-war > ${LOGFILE}  2>&1 &
    until savePID; do
      echo -n "."
      sleep 1
    done
    until isRunning "$HTTPPORT"; do
      echo -n "."
      sleep 4
    done
    echo ""
    return 0
 else
    return 1
 fi
}

# stop main class
function stopService(){
    cp -f resources/pom_deploy-war.xml ./pom.xml &&
    mvn jetty:stop
    echo 0 > ${PIDFILE}
    [ -f "${LOGFILE}" ] && rm ${LOGFILE}
    return 0
}

# print process id
function printPID(){
  echo process $(cat ${PIDFILE})
}

# save main process id
function savePID(){
  OUT=$(sudo lsof -n -i4TCP:$STOPPORT | grep LISTEN | awk '{print $2}')
  if [ -z "$OUT" ] ; then
      echo 0 > ${PIDFILE}
      return 1
  else
      echo $OUT > ${PIDFILE}
      return 0
  fi
}

# is process running?
function isRunning(){
  PORT="$1"
  PID=$(cat ${PIDFILE})
  readarray -t P <<< "$(sudo lsof -n -i4TCP:$PORT | grep LISTEN | awk '{print $2}')"
  PLen=${#P[@]}
  if [ $PLen == 0 ] ; then
      return 1
  else
     for p in ${P[@]}; do
        [ "$p" == "$PID" ] && return 0
     done
     return 1
  fi
}

# print main process status
function printStatus(){
   PROCESS=$1
   PID=$(cat ${PIDFILE})
   if [ "${PID}" == 0 ] ; then
   	  echo "$PROCESS stop/waiting"
   else
      echo "$PROCESS start/running, $(printPID)"
   fi
}

# show console
function showConsole(){
  [ -f "${LOGFILE}" ] && tail -f ${LOGFILE}
}

#---------------------------------------
# check arguments
if [ $# != 1 ] ; then show_help ; fi

initFiles

while [ $# -gt 0 ]; do
    case "$1" in
        start)
            if startService ; then
              printStatus $PROCESS
            fi
            shift
            ;;
        stop)
            if stopService ; then
              sleep 2
              printStatus $PROCESS
            fi
            shift
            ;;
        restart)
            if stopService ; then
              sleep 2
              startService
              printStatus $PROCESS
            fi
            shift
            ;;
        status)
            printStatus $PROCESS
            shift
            ;;
        console)
            showConsole
            shift
            ;;
        *)
            show_help
            ;;
    esac
    shift
done

exit 0

