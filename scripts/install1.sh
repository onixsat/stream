#!/bin/bash

## Install apache
echo "Install apache..."
sudo apt install zip unzip apache2 -y

sudo service apache2 start

## Install virtualhost to create vhost
echo "Install virtualhost create script..."
wget -O ~/virtualhost https://raw.githubusercontent.com/RoverWire/virtualhost/master/virtualhost.sh && sudo chmod +x ~/virtualhost && sudo mv ~/virtualhost /usr/local/bin/

## Install php

echo "Install php..."
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install php7.4 php7.4-dev php7.4-cli libapache2-mod-php7.4 php7.4-common php7.4-mbstring php7.4-xmlrpc php7.4-soap php7.4-gd php7.4-xml php7.4-intl php7.4-mysql php7.4-cli php7.4-zip php7.4-curl -y


echo "Install composer..."

wget https://getcomposer.org/download/1.10.17/composer.phar
sudo chmod +x composer.phar
sudo mv composer.phar /usr/local/bin/composer
