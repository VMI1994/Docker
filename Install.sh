#!/bin/bash

clear
echo "Updating your system"
sleep 1
sudo apt update
clear

echo "Installing dependencies"
sleep 1
# Install deps
sudo apt install -y curl wget apt-utils

# Which docker to install
clear
echo "1. Headless docker for command line only"
echo "2. Docker Desktop for GUI enviroments"
read choice
if [ $choice = "1" ]
then
    bash headless.sh
    exit
elif [ $choice = "2" ]
then
    bash desktop.sh
    exit
fi
