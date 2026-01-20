#!/bin/bash

clear
echo "Installing Docker"
sleep 2
curl -fsSL https://get.docker.com -o get-docker.sh
bash get-docker.sh

# Enable and start Docker
clear
echo "Enabling and starting docker"
sleep 2
sudo systemctl enable docker
sudo systemctl start docker
sudo service docker start
sudo service docker enable
sudo usermod -aG docker $USER

# Install portainer and watchtower
clear
echo "Install Dockhand"
sleep 2
sudo docker run -d --name dockhand --restart unless-stopped -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -v dockhand_data:/app/data fnsys/dockhand:latest

# Option to install open-webui and ollama
clear
echo "Do you want to install Artificial Intelligence (y/N)"
read option
if [ $option == "y" ]
then
    sudo docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
    sudo docker exec -it open-webui ollama pull gemma3:1b
    clear && echo "OpenWebUI is available at http://$(hostname -I | cut -d ' ' -f1):3000"
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

exit
