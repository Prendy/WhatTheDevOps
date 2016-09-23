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
rm -rf /var/www/html
ls -aRl
#sudo adduser --disabled-password --gecos "" andrew
#sudo adduser andrew www-data
#git clone https://github.com/cleahy3/node-project.git .
sudo cp ./config/default /etc/nginx/sites-available/default -f
#sudo chown -R vagrant:www-data ../../www
sudo chmod -R 0755 /var/www
sudo service nginx restart
sudo cp -R /root/workspace/Andrew/project/. /var/www/html
#sudo npm install
sudo npm install pm2 -g
#pm2 start app.js
