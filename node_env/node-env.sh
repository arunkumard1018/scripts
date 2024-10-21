#!/bin/bash

# Update the System
echo "Updating the system..."
sudo apt update
sudo apt upgrade -y

# Install Node.js and npm
echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js and npm Installation
echo "---------------------Installed Node.js with the following specifications ------------------------"
node -v
npm -v

# Install and Set up PM2
echo "Installing PM2..."
sudo npm install -g pm2

# Check PM2 status
echo "Checking PM2 status..."
pm2 status

echo "Setup completed successfully."

