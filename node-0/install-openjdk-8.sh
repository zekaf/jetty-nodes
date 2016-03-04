#!/bin/bash
#
# install openjdk-8 
#

# install
sudo add-apt-repository ppa:openjdk-r/ppa -y &&
sudo apt-get -y update &&
sudo apt-get -y install openjdk-8-jdk &&

# check it
java -version

#If you have more than one Java versions installed on your system. Run:
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
