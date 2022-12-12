#!/bin/bash
sudo apt-get update -y
sudo apt upgrade -y
sudo ufw disable
sudo apt-get install curl  wget -y
sudo apt-get install curl wget unzip zip -y
sudo apt-get install net-tools

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" | sudo tee  /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker


sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"      
unzip awscliv2.zip,
sudo ./aws/insta,
sudo apt-get update -y
sudo apt-get install jq  -y
swapoff -a; sed -i '/swap/d' /etc/fstab


sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

# Ensure that the br_netfilter module is loaded
lsmod | grep br_netfilter