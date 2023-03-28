#! /bin/bash

yum update -y
yum install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user
newgrp docker
curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir /home/ec2-user/bookstore
FOLDER="https://raw.githubusercontent.com/yavuz69/Docker-bookstore-project/main"
curl -s --create-dirs -o "/home/ec2-user/bookstore/Dockerfile" -L "$FOLDER"/Dockerfile
curl -s --create-dirs -o "/home/ec2-user/bookstore/docker-compose.yml" -L "$FOLDER"/docker-compose.yml
curl -s --create-dirs -o "/home/ec2-user/bookstore/requirements.txt" -L "$FOLDER"/requirements.txt
curl -s --create-dirs -o "/home/ec2-user/bookstore/bookstore-api.py" -L "$FOLDER"/bookstore-api.py 
cd /home/ec2-user/bookstore
docker build -t yavuz69/bookstoreapi:latest .
docker-compose up -d
depends_on = [github_repository.myrepo, github_repository_file.myfiles]