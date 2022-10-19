#!/bin/bash 
## this script to install jenkins tool
# update your system packages
sudo yum update –y
# install java 
sudo amazon-linux-extras install java-openjdk11 -y

# Adding repo to download your jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Enable install packages
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# then update your jenkins packages
sudo yum upgrade -y 

# install jenkins
sudo yum install jenkins -y

# start jenkins service
sudo systemctl start jenkins

# Enable jenkins service
sudo systemctl enable jenkins
sudo chkconfig jenkins on

# install git
sudo yum install git -y 