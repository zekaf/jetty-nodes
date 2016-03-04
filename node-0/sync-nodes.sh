#!/bin/bash

DIRN0="./"
HOSTS_FILE="hosts.txt"
HOST_NAME="node-"
DIRN="$HOME/$HOST_NAME"
NETWORK="10.10.3."
IF_NAME="tap-node-"
IP=""
BASEN=$(basename $BASH_SOURCE)
MAXNODES=254
S0=9090
H0=0
NODE0=0

# help message
function show_help(){
  echo "usage: ./$BASEN <total_nodes>"
  echo "(1 - 254), (0 = reset)"
  exit 1
}

# set IP/STOPPORT
function setVar(){
 replaceVar "9090" "$S0" "jetty-server.sh"
 replaceVar "9090" "$S0" "resources/pom_deploy-war.xml"
 replaceVar "0.0.0.0" "$IP" "resources/pom_deploy-war.xml"
 replaceVar "0.0.0.0" "$IP" "resources/pom_war.xml"
 replaceVar "0.0.0.0" "$IP" "pom.xml"
 evalCMD "echo $IP $HOST_NAME$NODE0 >> $HOSTS_FILE"
}

# set /etc/hosts
function setHost(){
  if sudo ./etc-hosts.sh check "$1"; then
     evalCMD "sudo ./etc-hosts.sh update $1 $2"
  else
     evalCMD "sudo ./etc-hosts.sh add $1 $2"  
  fi
}

# set /etc/hosts
function importHost(){
  if [ -f "$HOSTS_FILE" ]; then
     evalCMD "sudo ./etc-hosts.sh import $HOSTS_FILE"  
  else
     echo "$HOSTS_FILE ERROR!"
     exit 1
  fi
}

# reset
function reset(){
 replaceVar "$S0" "9090" "jetty-server.sh"
 replaceVar "$S0" "9090" "resources/pom_deploy-war.xml"
 replaceVar "$IP" "0.0.0.0" "resources/pom_deploy-war.xml"
 replaceVar "$IP" "0.0.0.0" "resources/pom_war.xml"
 replaceVar "$IP" "0.0.0.0" "pom.xml"
 setHost "$HOST_NAME$NODE0" "127.0.0.1"

 for (( i=1; i<=MAXNODES; i++ ))
 do
   if [[ -d "$DIRN$i" ]]; then
      evalCMD "rm -rfv $DIRN$i"
   fi
   declare -i HOST=$H0
   let HOST=HOST+$i
   IF="$IF_NAME$HOST"
   if [ -f /sys/class/net/${IF}/operstate ]; then
      evalCMD "sudo tunctl -d $IF"
   fi
   if sudo ./etc-hosts.sh check "$HOST_NAME$i"; then
      evalCMD "sudo ./etc-hosts.sh remove $HOST_NAME$i"
   fi
 done

 if [[ -d "target" ]]; then
      evalCMD "rm -rfv target"
 fi
  
 if [ -f "$HOSTS_FILE" ]; then 
    rm -f "$HOSTS_FILE"
 fi
}

# install package
function do_install(){
	pkg="$1"
	if sudo apt-get -qq install $pkg; then
		echo "successfully installed package $pkg"
	else
		echo "error installing package $pkg"
		exit 1
	fi
}

# initialize
function initialize(){
	do_install "uml-utilities"
	sudo modprobe tun
	if [ -f "$HOSTS_FILE" ]; then 
		rm -f "$HOSTS_FILE"
	fi 
}

# run command
function evalCMD(){
	CMD=$1
	echo "$CMD"
	eval "$CMD"
}

function replaceVar(){
  VAR1="$1"
  VAR2="$2"
  FILE="$3"
  evalCMD "perl -pi -e 's/$VAR1/$VAR2/g' $FILE"
}

# create tap interface
function mkTun(){
	declare -i HOST=$H0
	let HOST=HOST+$1
	IF="$IF_NAME$HOST"
	if [ ! -f /sys/class/net/${IF}/operstate ]; then
	  evalCMD "sudo tunctl -t $IF"
	  evalCMD "sudo ifconfig $IF $NETWORK$HOST netmask 255.255.255.0 up"
	  UP=$(cat /sys/class/net/${IF}/operstate)
	    if [[ $UP == "up" ]]; then
		ifconfig "$IF"
	    else
		echo "$IF down"
	    fi
  	fi
}

# make/sync node directory
function syncDir(){
	DIR="$DIRN$1"
	evalCMD "echo $NETWORK$HOST $HOST_NAME$1 >> $HOSTS_FILE"
	if [[ ! -d "$DIR" ]]; then
		evalCMD "mkdir $DIR"
		evalCMD "rsync -av  --exclude-from 'exclude-0.txt' $DIRN0/ $DIR"
		declare -i STOPPORT=$S0
		declare -i HOST=$H0
		let STOPPORT=STOPPORT+$1
		let HOST=HOST+$1
		replaceVar "$S0" "$STOPPORT" "$DIR/jetty-server.sh"
		replaceVar "$S0" "$STOPPORT" "$DIR/resources/pom_deploy-war.xml"
		replaceVar "$S0" "$STOPPORT" "$DIR/pom.xml"
		replaceVar "$IP" "$NETWORK$HOST" "$DIR/resources/pom_deploy-war.xml"
		replaceVar "$IP" "$NETWORK$HOST" "$DIR/resources/pom_war.xml"
		replaceVar "$IP" "$NETWORK$HOST" "$DIR/pom.xml"
	else
		evalCMD "rsync -av  --exclude-from 'exclude-1.txt' $DIRN0/ $DIR"
	fi
}

function getIP(){
   IP=$(hostname  -I | cut -f1 -d' ')
}

if [ $# != 1 ] ; then
   show_help;
fi

let NODES=$1

if [[ $NODES -lt 0 ]] || [[ $NODES -gt $MAXNODES ]] ; then
   show_help;
fi

if [[ $NODES -eq 0 ]]; then
   getIP
   echo "reset.."
   reset;
   echo "done!"
   exit 0
fi

getIP
initialize
setVar

for (( i=1; i<=NODES; i++ ))
do
   mkTun $i
   syncDir $i
done

importHost

echo "done!"

exit 0
