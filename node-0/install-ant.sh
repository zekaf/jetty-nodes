#!/bin/sh

VER="1.9.6"
BIN="apache-ant-${VER}-bin" 
URL="http://mirrors.fe.up.pt/pub/apache/ant/binaries/${BIN}.tar.gz"
sudo apt-get purge -y ant
$(curl -OL $URL)
sudo mkdir /usr/local/apache-ant
sudo mv ${BIN}.tar.gz /usr/local/apache-ant
sudo tar -xzvf /usr/local/apache-ant/${BIN}.tar.gz -C /usr/local/apache-ant/
sudo update-alternatives --install /usr/bin/ant ant /usr/local/apache-ant/apache-ant-${VER}/bin/ant 1
sudo update-alternatives --config ant

if [ -f /etc/profile.d/ant.sh ]; then
    sudo rm /etc/profile.d/ant.sh
fi

if [ -f /tmp/ant.sh ]; then
    rm /tmp/ant.sh
fi

$(touch /tmp/ant.sh)
$(echo "export ANT_HOME=/usr/local/apache-ant/apache-ant-${VER}" > /tmp/ant.sh)
sudo cp /tmp/ant.sh /etc/profile.d/ant.sh 
sudo apt-get -y autoremove
CMD="ant -version"
eval $CMD
