#!/bin/bash

# Define the server name and app port
SERVER_NAME="example.com www.example.com"
APP_PORT="8001"

# Backup the default Nginx configuration
echo "Backing up the existing Nginx configuration..."
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Write the new configuration to the default Nginx site
echo "Setting up Nginx configuration..."
sudo bash -c "cat > /etc/nginx/sites-available/default <<EOF
server {
    server_name $SERVER_NAME;

    location / {
        proxy_pass http://localhost:$APP_PORT; # whatever port your app runs on
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF"

# Test the Nginx configuration
echo "Testing Nginx configuration..."
if sudo nginx -t; then
    echo "Nginx configuration is valid. Reloading Nginx..."
    sudo nginx -s reload
    echo "Nginx has been reloaded successfully."
else
    echo "Nginx configuration is invalid. Please check the configuration."
    exit 1
fi

