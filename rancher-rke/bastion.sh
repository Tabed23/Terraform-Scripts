#!/bin/bash
sudo apt-get update -y
sudo apt upgrade -y
sudo ufw disable
sudo apt-get install curl wget unzip zip -y
sudo apt-get install net-tools
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"      
unzip awscliv2.zip,
sudo ./aws/insta,
sudo apt-get update -y
sudo apt-get install jq  -y
swapoff -a; sed -i '/swap/d' /etc/fstab


# Download RKE
curl -LO https://github.com/rancher/rke/releases/download/v1.2.11/rke_linux-amd64 && chmod a+x ./rke_linux-amd64
mv rke_linux-amd64 rke
sudo mv rke /usr/local/bin/


cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# Download and install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl