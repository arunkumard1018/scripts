#!/bin/bash

# Define the server name and app port
SERVER_NAME="api.strixinvoice.online"
APP_PORT="8001"

# Backup the default Nginx configuration
echo "Backing up the existing Nginx configuration..."
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Function to escape dollar signs in a string
escape_dollar_signs() {
    echo "$1" | sed -e 's/\$/\\$/g'
}

# Write the new configuration to the default Nginx site
echo "Setting up Nginx configuration..."
sudo bash -c "cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    server_name $SERVER_NAME;

    location / {
        proxy_pass http://localhost:$APP_PORT; # whatever port your app runs on
        proxy_http_version 1.1;
        proxy_set_header Upgrade $(escape_dollar_signs "\$http_upgrade");  # Escaped dollar sign
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $(escape_dollar_signs "\$host");              # Escaped dollar sign
        proxy_cache_bypass $(escape_dollar_signs "\$http_upgrade");         # Escaped dollar sign
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
