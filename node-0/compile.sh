#!/bin/bash


function show_help() {
  echo "usage: ./$(basename $BASH_SOURCE) jar|war"
  exit 1
}

function buildJAR(){
	./main.sh stop
	rm -rf target &&
	cp -f resources/pom_jar.xml ./pom.xml &&
	mvn clean install 
}

function buildWAR(){
	./main.sh stop
	rm -rf target &&
	cp -f resources/pom_war.xml ./pom.xml &&
	mvn jetty:run-war 
}

# check arguments
if [ $# != 1 ] ; then show_help ; fi

while [ $# -gt 0 ]; do
    case "$1" in
        jar) 
			buildJAR
            shift 
            ;;
        war) 
			buildWAR
            shift 
            ;;         
        *) 
            show_help 
            ;;    
    esac
    shift
done


