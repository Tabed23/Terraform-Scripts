#!/bin/bash

sudo apt update && sudo apt upgrade  -y 
sudo apt install  wget net-tools -y
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo apt install nodejs npm -y

# INSTALL MYSQL
sudo apt install mysql-server

# INSTALL NVM & PM2
sudo apt install curl
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.bashrc  
nvm install node  
nvm install node 
npm install pm2 -g

sudo apt update && sudo apt -y full-upgrade
sudo apt install curl gnupg2 apt-transport-https software-properties-common ca-certificates -y


#DOCKER
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" | sudo tee  /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER

# DOCKER COMPOSE
curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
chmod +x docker-compose-linux-x86_64
sudo mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose