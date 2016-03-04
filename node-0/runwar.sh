#!/bin/bash

CLASSPATH="com.rest.test"
JARPATH="target/restprj-1.0-SNAPSHOT/WEB-INF/lib/"
JARFILE="*"

# print help message
function show_help() {
  echo "usage: ./$(basename $BASH_SOURCE) <Java_Class>"
  exit 1
}

# run Java Class from Jar file 
function runJavaClass(){
 CLASS=$1
 CMD="java -cp \"$JARPATH$JARFILE\" $CLASSPATH.$CLASS"
 echo $CMD
 eval $CMD
}

if [ $# != 1 ] ; then show_help ; fi

runJavaClass $1
