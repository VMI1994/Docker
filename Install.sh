#!/bin/bash

clear
echo "Installing dependencies"

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
