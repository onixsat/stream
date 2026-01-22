#!/usr/bin/env bash


echo "${BLUE}Atualizando o sistema...${NORMAL}"
sudo yum update -y ;
sudo yum upgrade -y ;
dnf install wget curl -y ;
dnf install php-dev php-pecl -y ;
sudo yum install openssh-clients -y ;
echo "${WHITE}Atualizado!"
banner 2

echo "${BLUE}Stopping and disabling NetworkManager and disabling SELINUX.${NORMAL}"
systemctl stop NetworkManager ;
systemctl disable NetworkManager ;
NOW=$(date +"%m_%d_%Y-%H_%M_%S")
cp /etc/selinux/config /etc/selinux/config.bckup.$NOW
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config ;
log "NetworkManager stopped and disabled."
echo "${WHITE}NetworkManager stopped and disabled."
echo "${WHITE}Selinux Disabled."
banner 2

echo "${BLUE}Enabling / Updating initial quotas! A reboot in the end will be required.${NORMAL}"
yes |  /scripts/initquotas ;
echo "${WHITE}Server quotas are enabled!"
