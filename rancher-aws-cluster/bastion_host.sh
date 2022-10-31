#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install curl wget -y
sudo apt install nginx -y

# Install utils and aws cli v2
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo snap install jq
sudo apt update
sudo apt install zip
sudo apt install unzip
sudo unzip awscliv2.zip
sudo ./aws/install

sudo touch home/ubuntu/private_key
echo ${var.pem} > /home/ubuntu/private_key

PEM=$(aws secretsmanager get-secret-value --region=us-west-1  --query SecretString --secret-id ${var.pem} --output json | jq --raw-output)
echo $PEM > /home/ubuntu/private_key.pem
chmod 400 private_key.pem