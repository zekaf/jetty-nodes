#!/bin/bash
#
# install lates OpenJDK
#

# install
sudo apt-get -y update &&
sudo apt-get -y install default-jdk &&

# check version
java -version
javac -version

#If you have more than one Java versions installed on your system. Run:
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
