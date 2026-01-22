#!/usr/bin/env bash

titulo "Atualizando o sistema..."
sudo yum update -y ;
sudo yum upgrade -y ;
dnf install wget curl zip unzip net-tools yum-utils -y ;
esperar "sleep 1" "${WHITE}Atualizando... "

titulo "Stopping and disabling NetworkManager and disabling SELINUX."
systemctl stop NetworkManager ;
systemctl disable NetworkManager ;
NOW=$(date +"%m_%d_%Y-%H_%M_%S")
cp /etc/selinux/config /etc/selinux/config.bckup.$NOW
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config ;
log "NetworkManager stopped and disabled."
echo "${WHITE}NetworkManager stopped and disabled."
echo "${WHITE}Selinux Disabled."

titulo "Enabling / Updating initial quotas! A reboot in the end will be required."
yes |  /scripts/initquotas ;
echo "${WHITE}Server quotas are enabled!"
esperar "sleep 1" "${WHITE}Server quotas are enabled! "


titulo "Atualizando a password..."
echo "${password}" | passwd --stdin root
esperar "sleep 1" "${WHITE}Atualizando... "

titulo "Atualizando a porta ssh..."
echo -n "${MAGENTA}Enter SSH port to change from ${BLUE}${sshport}${MAGENTA}:${NORMAL} "
while read SSHPORT; do
    if [[ "$SSHPORT" =~ ^[0-9]{2,5}$ || "$SSHPORT" = 22 ]]; then
        if [[ "$SSHPORT" -ge 1024 && "$SSHPORT" -le 65535 || "$SSHPORT" = 22 ]]; then
            NOW=$(date +"%m_%d_%Y-%H_%M_%S")
            cp /etc/ssh/sshd_config /etc/ssh/sshd_config.inst.bckup.$NOW
            sed -i -e "/Port /c\Port $SSHPORT" /etc/ssh/sshd_config
            echo -e "${CYAN}Restarting SSH in 2 seconds. ${NORMAL}Please wait."
            sleep 2
            service sshd restart
            echo -e "\n${RED}The SSH port has been changed to $SSHPORT."
            echo -n "${WHITE}Please login using that port to test BEFORE ending this session."
            echo "${WHITE}"
            tput init
            break
        else
            echo -e "${RED}Invalid port: must be 22, or between 1024 and 65535."
            echo -n "${NORMAL}Please enter the port you would like SSH to run on ${WHITE}> "
        fi
    else
        echo -e "${RED}Invalid port: must be numeric!"
        echo -n "${NORMAL}Please enter the port you would like SSH to run on ${WHITE}> "
    fi
done
