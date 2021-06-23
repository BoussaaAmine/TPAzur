#!/bin/bash
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

#Installation de nginx, nodejs et git

sudo apt-get -y update 
sudo apt-get -y install nginx nodejs git

#Installation de npm

sudo npm install -g pm2

#clone de l'application
git clone https://github.com/Azure-Samples/nodejs-docs-hello-world.git

sudo pm2 start -f nodejs-docs-hello-world/index.js

#entrer en mode root
sudo su -

#Remplacement du contenu de /etc/nginx/sites-available/default
echo "server {
        listen 80;
        location / {
          proxy_pass http://localhost:1337/;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection keep-alive;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
        }
      }" > /etc/nginx/sites-available/default



#Restart nginx
sudo nginx service restart