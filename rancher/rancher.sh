#! /bin/bash
sudo curl https://releases.rancher.com/install-docker/20.10.sh | sh

sudo docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -e CATTLE_BOOTSTRAP_PASSWORD=passwordpassword \
  --privileged \
  rancher/rancher:latest \
  --acme-domain r.iamedem.name



