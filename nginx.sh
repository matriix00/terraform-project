#!/bin/bash

apt-get update
apt-get -y install nginx
service nginx start
echo " hello from nginx $(hostname -f)" > /var/www/html/index.nginx-debian.html