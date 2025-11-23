#!/bin/bash

clear
sudo apt install -y curl wget ca-certificates
#curl -fsSL https://get.docker.com -o get-docker.sh
#bash get-docker.sh

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
clear
echo "start Docker desktop and wait for startup to complete before hitting enter to continue"
read pause

# Enable and start Docker
sudo usermod -aG docker $USER

# Install portainer and watchtower
clear
echo "Install portainer and watchtower"
sleep 2
sudo docker volume create portainer_data
sudo docker run -d -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
clear
sudo docker run  -d -v /var/run/docker.sock:/var/run/docker.sock --name watchtower nickfedor/watchtower

# Option to install open-webui and ollama
clear
echo "Do you want to install Artificial Intelligence (y/N)"
read option
if [ $option == "y" ]
then
    sudo docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
    sudo docker exec -it open-webui ollama pull gemma3:1b
    clear && "OpenWebUI is available at http://127.0.0.1:3000"
fi

# Check Containers
clear
echo ""
echo ""
echo "We will now check running docker containers"
sleep 2
sudo docker ps
echo ""
echo ""

# Check install
which docker > /dev/null
if [ $? == 0 ]
then
  echo "Docker Install Successful"
else
  echo "Docker Install Failed"
fi
sleep 2
exit
