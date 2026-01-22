#!/usr/bin/env bash

globais

echo "${BLUE}Atualizando a password...${NORMAL}"
echo 'Password2024' | passwd --stdin root
echo "${WHITE}Atualizado!"
banner 2

echo "${BLUE}Atualizando a porta ssh..."
echo -n "${MAGENTA}Enter SSH port to change from ${BLUE}${sshport}${MAGENTA}:${NORMAL} "
while read SSHPORT; do
    if [[ "$SSHPORT" =~ ^[0-9]{2,5}$ || "$SSHPORT" = 22 ]]; then
        if [[ "$SSHPORT" -ge 1024 && "$SSHPORT" -le 65535 || "$SSHPORT" = 22 ]]; then
            NOW=$(date +"%m_%d_%Y-%H_%M_%S")
            cp /etc/ssh/sshd_config /etc/ssh/sshd_config.inst.bckup.$NOW
            sed -i -e "/Port /c\Port $SSHPORT" /etc/ssh/sshd_config
            echo -e "${CYAN}Restarting SSH in 5 seconds. ${NORMAL}Please wait."
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
