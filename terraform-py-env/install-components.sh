#!/bin/bash

# Install Apache on Ubuntu
sudo yum check-update
sudo yum -y update

#inctall docker 
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Install Java (OpenJDK 11 in this example)
sudo yum install java-11-openjdk -y

#install git 
sudo yum install git -y

#install python 
sudo yum install python -y

#install flask
sudo yum install pip -y
sudo pip3 install flask -y   #not sure if we need the -y
