#! /bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable