#!/bin/bash


#---------------------------------------
JARPATH="target/"
JARFILE="restprj-1.0-SNAPSHOT.jar"
PIDFILE="/tmp/mainclass.pid"
LOGFILE="/tmp/mainclass.log"

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
    if ! isRunning $JARFILE $PID ; then
        resetFiles
    fi 
fi
}

# reset files
function resetFiles(){
  echo 0 > ${PIDFILE}  
  [ -f "${LOGFILE}" ] && rm ${LOGFILE}  
}

# start main class
function startMainJavaClass(){
 PROCESS=$1  
 if grepPID $PROCESS ; then
    # process is already running 
    return 1
 fi  
 PID=$(cat ${PIDFILE})
 if [ "$PID" == 0 ] || [ -z "$PID" ] ; then
    # start process
    nohup java -jar $JARPATH$JARFILE > ${LOGFILE}  2>&1 &
    echo "$!" > ${PIDFILE}
    return 0
 else 
    return 1
 fi   
}

# stop main class
function stopMainJavaClass(){
 PROCESS=$1  
 PID=$(cat ${PIDFILE})
 if [ "$PID" != 0 ] ; then
    kill "${PID}" &&
    echo 0 > ${PIDFILE}
    [ -f "${LOGFILE}" ] && rm ${LOGFILE} 
    return 0
 else
    return 1   
 fi 
}

# print process id 
function printPID(){
  echo process $(cat ${PIDFILE})
}  

# get main process id
function grepPID(){
  PROCESS=$1
  # first char of process 
  FIRSTC=${PROCESS:0:1}
  # rest chars of process
  RESTC=$(echo $PROCESS | cut -c2-) 
  OUT=$(ps aux | grep [$FIRSTC]$RESTC |  awk '{print $2}')
  if [ -z "$OUT" ] ; then
      return 1 
  else
      return 0 
  fi 
}

# is process running?
function isRunning(){
  PROCESS=$1
  PID=$2
  # first char of process 
  FIRSTC=${PROCESS:0:1}
  # rest chars of process
  RESTC=$(echo $PROCESS | cut -c2-) 
  OUT=$(ps aux | grep [$FIRSTC]$RESTC |  awk '{print $2}')
  if [ -z "$OUT" ] ; then
      return 1 
  else
      if [ "$OUT" == "$PID" ] ; then 
        return 0
      else
        return 1
      fi   
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
            if startMainJavaClass $JARFILE ; then
              printStatus $JARFILE  
            fi
            shift 
            ;;
        stop) 
            if stopMainJavaClass $JARFILE; then
              sleep 2 
              printStatus $JARFILE 
            fi
            shift 
            ;;
        restart) 
            if stopMainJavaClass $JARFILE; then
              sleep 2 
              startMainJavaClass $JARFILE 
              printStatus $JARFILE 
            fi
            shift 
            ;;            
        status) 
            printStatus $JARFILE 
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

