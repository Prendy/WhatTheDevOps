#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install git nginx nodejs build-essential npm nodejs-legacy mongodb-org -y
sudo tee -a /etc/systemd/system/mongodb.service <<EOF
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
EOF
sudo service mongod start
cd /var/www/html
rm index.nginx-debian.html
sudo adduser --disabled-password --gecos "" andrew
sudo adduser andrew www-data
sudo cp ~/servers/webserver/config/nginx.conf /etc/nginx/nginx.conf -f
git clone https://github.com/cleahy3/node-project.git .
sudo cp ~/servers/webserver/config/default /etc/nginx/sites-available/default -f
sudo chown -R www-data:www-data ../../www/*
sudo chmod -R 0755 ../../www/*
sudo service nginx restart
