#!/bin/bash

# basic patching
sudo yum -y update

# docker
sudo yum -y install docker
sudo service docker start

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# login to ECR
sudo aws ecr get-login --no-include-email --region eu-west-2 > login.sh
sudo bash login.sh

# get docker-compose from S3
sudo aws s3api get-object \
  --bucket docker-compose-engagement \
  --key docker-compose.yml \
  docker-compose.yml

# get nginx configuration
sudo mkdir container-balancer && cd container-balancer
sudo aws s3api get-object \
  --bucket docker-compose-engagement \
  --key container-balancer/nginx.conf \
  nginx.conf

# create /etc/nginx directory if not exists
sudo mkdir -p /etc/nginx

# run app
sudo docker-compose up