#!/bin/bash

# this script is only tested on ubuntu xenial

# Install git
apt-get update -y
apt-get install git-core
git config --global user.name "Dibyendu" 
git config --global user.email "dasdib@gmail.com"

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home/

# Git clone 
git clone https://github.com/dasdib/jenkins.git

cd jenkins
docker-compose up -d
# show endpoint
echo 'Jenkins installed'
echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'
