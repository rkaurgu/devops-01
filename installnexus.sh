#! /bin/bash

# Install Java
sudo yum install java-1.8.0-openjdk.x86_64 -y

# Update the packages
sudo yum update –y
# Download Nexus
cd /opt/
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
# Unzip/Untar the compressed file
sudo tar -zxvf latest-unix.tar.gz
# Rename folder for ease of use
sudo mv nexus-3.* nexus3
# Enable permission for ec2-user to work on nexus3 and sonatype-work folders
sudo chown -R ec2-user:ec2-user nexus3/ sonatype-work/
# Create a file called nexus.rc and add run as ec2-user
sudo rm /opt/nexus3/nexus.rc
sudo cd /opt/nexus3/bin/
sudo touch nexus.rc
sudo echo 'run_as_user="ec2-user"' | sudo tee -a /opt/nexus3/bin/nexus.rc
# Add nexus as a service at boot time
sudo ln -s /opt/nexus3/bin/nexus /etc/init.d/nexus
sudo cd /etc/init.d
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on
# Start Nexus
sudo systemctl start nexus