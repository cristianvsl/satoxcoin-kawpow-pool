#!/bin/sh

# This is the Pool install script.
echo "JAMPS Ravencoin Pool install script."
echo "Please do NOT run as root, run as the pool user!"

echo "Installing... Please wait!"

sleep 5

sudo rm -rf /usr/lib/node_modules
sudo rm -rf node_modules
sudo rm /etc/apt/sources.list.d/*
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install -y apt-transport-https software-properties-common build-essential autoconf pkg-config make gcc g++ screen wget curl ntp fail2ban 

sudo apt update
sudo apt install -y libdb-dev libdb++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable ntp
sudo systemctl start ntp

npm install -g pm2@4.5.6
npm install -g npm@latest-6

npm install
npm update
npm audit fix
npm install sha3
npm install logger

echo "Installation completed!"

exit 0
