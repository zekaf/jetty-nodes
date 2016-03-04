#!/bin/sh

VER="3.3.9"
BIN="apache-maven-${VER}-bin" 
URL="http://mirrors.fe.up.pt/pub/apache/maven/maven-3/${VER}/binaries/${BIN}.tar.gz"
sudo apt-get purge -y maven
$(curl -OL $URL)
sudo mkdir /usr/local/apache-maven
sudo mv ${BIN}.tar.gz /usr/local/apache-maven
sudo tar -xzvf /usr/local/apache-maven/${BIN}.tar.gz -C /usr/local/apache-maven/
sudo update-alternatives --install /usr/bin/mvn mvn /usr/local/apache-maven/apache-maven-${VER}/bin/mvn 1
sudo update-alternatives --config mvn

if [ -f /etc/profile.d/ant.sh ]; then
    sudo rm /etc/profile.d/ant.sh
fi

if [ -f /tmp/ant.sh ]; then
    rm /tmp/ant.sh
fi

$(touch /tmp/mvn.sh)
$(echo "export M2_HOME=/usr/local/apache-maven/apache-maven-${VER}" > /tmp/m2.sh)
$(echo "export MAVEN_OPTS=\"-Xms256m -Xmx512m\""  >> /tmp/m2.sh)
sudo cp /tmp/m2.sh /etc/profile.d/m2.sh 
sudo apt-get -y autoremove
CMD="mvn -version"
eval $CMD
