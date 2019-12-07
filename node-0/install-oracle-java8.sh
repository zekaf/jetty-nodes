#!/bin/bash
#
# install Oracle Java JDK using PPA repository
#

# Java version
VERSION=12

# install
apt-get -y -q update
apt-get -y -q upgrade
apt-get -y -q install software-properties-common 
sudo add-apt-repository ppa:linuxuprising/java -y &&
sudo apt-get -y update &&
#echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
#echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt install oracle-java$VERSION-installer-local

# set environment variables
sudo apt install oracle-java$VERSION-set-default-local

# check it
java -version

#If you have more than one Java versions installed on your system. Run:
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
