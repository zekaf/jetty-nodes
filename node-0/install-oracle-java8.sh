#!/bin/bash
#
# install Java 8 JDK using Webup8 Oracle Java8 installer
#

# install
apt-get -y -q update
apt-get -y -q upgrade
apt-get -y -q install software-properties-common htop
sudo apt-add-repository ppa:webupd8team/java -y &&
sudo apt-get -y update &&
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y -q install oracle-java8-installer

sudo apt-get -y install oracle-java8-installer &&

# set environment variables
sudo apt-get -y install oracle-java8-set-default

# check it
java -version

#If you have more than one Java versions installed on your system. Run:
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
