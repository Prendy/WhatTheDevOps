#!/bin/bash

sudo apt-get update
sudo apt-get install git nginx nodejs build-essential npm nodejs-legacy -y
cd /var/www/html
rm index.nginx-debian.html
#sudo adduser --disabled-password --gecos "" andrew
#sudo adduser andrew www-data
#git clone https://github.com/cleahy3/node-project.git .
sudo cp ~/servers/webserver/config/default_api /etc/nginx/sites-available/default -f
sudo chown -R www-data:www-data /var/www/*
sudo chmod -R 0755 /var/www/*
sudo service nginx restart
sudo npm install pm2 -g
