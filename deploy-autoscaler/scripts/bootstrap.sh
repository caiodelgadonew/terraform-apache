#!/bin/bash
apt update -y
apt install apache2 -y
systemctl enable apache2
systemctl start apache2
echo -e "<h1>Welcome to Apache2 Webserver</h1>\n<b>You are on server:</b>  $(hostname)" > /var/www/html/index.html