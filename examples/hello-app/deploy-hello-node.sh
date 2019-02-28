#!/bin/bash

# update packages
sudo yum -y update

# download and start docker
sudo yum -y install docker

#sudo systemctl start docker
sudo service docker start 

# pull docker app
sudo docker pull rafaelmarques7/hello-node:latest

# run docker app
sudo docker run -d -p 80:80 rafaelmarques7/hello-node:latest

echo "hi :)" > text.txt
