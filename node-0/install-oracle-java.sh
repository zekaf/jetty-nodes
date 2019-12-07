#!/bin/bash
#
# install Oracle Java JDK using PPA repository
#

# Java version
VERSION=13

# install
sudo apt-get -y -q update
sudo apt-get -y -q install software-properties-common 
sudo add-apt-repository ppa:linuxuprising/java -y
sudo apt-get -y update
sudo apt-get -y install oracle-java$VERSION-installer

# set environment variables
sudo apt-get -y install oracle-java$VERSION-set-default

# check version
java -version
javac -version

#If you have more than one Java versions installed on your system. Run:
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
