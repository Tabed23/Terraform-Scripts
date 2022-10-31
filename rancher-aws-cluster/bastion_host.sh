
#!/bin/bash
sudo apt update -y && sudo apt upgrade -y

sudo apt install curl wget -y

# Install utils and aws cli v2
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install jq
sudo apt update
sudo apt install zip
sudo apt install unzip
sudo unzip awscliv2.zip
sudo ./aws/install