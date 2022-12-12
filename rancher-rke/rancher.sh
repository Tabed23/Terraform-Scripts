#! /bin/bash
sudo apt-get update -y
sudo apt upgrade -y

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" | sudo tee  /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker
#sudo docker run -d  --name rks-server --restart=unless-stopped -p 80:80 -p 443:443 --privileged -v /opt/rancher:/var/lib/rancher rancher/rancher:latest
sudo docker run -d --name rks-server -v /opt/rancher:/var/lib/rancher --restart=unless-stopped -p 80:80 -p 443:443  -e CATTLE_BOOTSTRAP_PASSWORD=passwordpassword --privileged rancher/rancher:latest

# Configure sysctl.
sudo modprobe overlay
sudo modprobe br_netfilter