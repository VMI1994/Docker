#!/bin/bash

clear
# Deps
sudo apt install -y curl wget ca-certificates

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
bash get-docker.sh
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
sudo dpkg -i docker-desktop-amd64.deb
sudo apt --fix-broken install -y
sudo rm /etc/xdg/systemd/user/docker-desktop.service
sudo systemctl --user enable docker-desktop
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
