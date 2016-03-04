#!/bin/bash

CLASSPATH="com.rest.test"
JARPATH="target/"
JARFILE="restprj-1.0-SNAPSHOT.jar"

# print help message
function show_help() {
  echo "usage: ./$(basename $BASH_SOURCE) <Java_Class>"
  exit 1
}

# run Java Class from Jar file 
function runJavaClass(){
 CLASS=$1
  CMD="java -cp \"$JARPATH$JARFILE\" $CLASSPATH.$CLASS"
 eval $CMD
}

if [ $# != 1 ] ; then show_help ; fi

runJavaClass $1
