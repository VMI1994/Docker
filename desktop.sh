#!/bin/bash

clear
# Deps
sudo apt install -y curl wget ca-certificates

# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update


wget https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
sudo dpkg -i docker-desktop-amd64.deb
sudo apt --fix-broken install -y
sudo rm /etc/xdg/systemd/user/docker-desktop.service
sudo systemctl --user enable docker-desktop
sudo docker context use desktop-linux
sudo usermod -aG docker $USER

# Check install
clear 
which docker > /dev/null
if [ $? == 0 ]
then
  echo "Docker Install Successful"
else
  echo "Docker Install Failed"
fi
sleep 2
exit
