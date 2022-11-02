#! /bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged -v /opt/rancher:/var/lib/rancher rancher/rancher:latest
