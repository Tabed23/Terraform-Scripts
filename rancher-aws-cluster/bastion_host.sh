
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

PEM=$(aws secretsmanager get-secret-value --region=us-west-2  --query SecretString --secret-id arn:aws:secretsmanager:us-west-2:484087752115:secret:secret_pem-rdQEFA --output json | jq --raw-output)
echo $PEM > private_key.pem
chmod 400 private_key.pem