#!/bin/bash

# Add Certbot PPA
echo "Adding Certbot PPA..."
sudo add-apt-repository ppa:certbot/certbot -y

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install Certbot for Nginx
echo "Installing Certbot for Nginx..."
sudo apt-get install -y python3-certbot-nginx

# Obtain SSL certificates for your domain
DOMAIN1="yourdomain.com"
DOMAIN2="www.yourdomain.com"

echo "Obtaining SSL certificates for $DOMAIN1 and $DOMAIN2..."
sudo certbot --nginx -d $DOMAIN1 -d $DOMAIN2

# Test the renewal process
echo "Testing the renewal process..."
sudo certbot renew --dry-run

echo "Setup completed successfully."

