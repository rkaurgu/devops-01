#!/bin/bash
# add the user ansible admin
useradd ansibleadmin
# set password : the below command will avoid re entering the password
echo "ansible123" | passwd --stdin ansibleadmin
# modify the sudoers file at /etc/sudoers and add entry
echo 'ansibleadmin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
echo 'ec2-user     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
# this command is to add an entry to file : echo 'PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
# the below sed command will find and replace words with spaces "PasswordAuthentication no" to "PasswordAuthentication yes"
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart

# update packeges
yum update -y
# install most latet dockert engine
amazon-linux-extras install docker -y
# start docket service
systemctl start docker
# enable docker service
systemctl enable docker
# add ec2-user group
usermod -a -G docker ansibleadmin
