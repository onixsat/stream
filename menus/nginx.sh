#!/bin/sh
globais

read -r -d '' ENV_VAR_MENU << EOM
  Menu ${BLUE}- ${BOLD}${RED}Nginx${NORMAL}
EOM
createMenu "menuNginx" "$ENV_VAR_MENU"
addMenuItem "menuNginx" "Atualizar" showNovo
addMenuItem "menuNginx" "Original" showOriginal
addMenuItem "menuNginx" "Sub Menu" showSubmenu2

function showNovo(){

	banner "Menu" "Nginx" "Atualizar"
	
	sudo chattr -i /etc/nginx/sites-available/lb.conf
	sudo rm /etc/nginx/sites-available/lb.conf
	
	sudo chattr -i /etc/nginx/sites-available/bo.conf
	sudo rm /etc/nginx/sites-available/bo.conf
	
  	sudo wget "https://raw.githubusercontent.com/onixsat/stream/refs/heads/main/files/lb.conf?raw=True" -O /etc/nginx/sites-available/lb.conf
  	sudo wget "https://raw.githubusercontent.com/onixsat/stream/refs/heads/main/files/bo.conf?raw=True" -O /etc/nginx/sites-available/bo.conf
	
	if [ $? -eq 0 ]; then
		echo "Command Executed Successfully"
	else
		echo "Command Failed"
	fi
	
  	sudo chattr +i /etc/nginx/sites-available/lb.conf
	sudo chattr +i /etc/nginx/sites-available/bo.conf
	
	esperar "sleep 2" "Atualizando..." " ${WHITE} Atualizado!"

	reload "return" "menuNginx"
	pause
	
}

function showOriginal(){
	banner "Menu" "Nginx" "Originais"
	
	sudo chattr -i /etc/nginx/sites-available/lb.conf
	sudo rm /etc/nginx/sites-available/lb.conf
	
	sudo chattr -i /etc/nginx/sites-available/bo.conf
	sudo rm /etc/nginx/sites-available/bo.conf
	
  	sudo wget "https://raw.githubusercontent.com/onixsat/stream/refs/heads/main/files/originais/lb.conf?raw=True" -O /etc/nginx/sites-available/lb.conf
  	sudo wget "https://raw.githubusercontent.com/onixsat/stream/refs/heads/main/files/originais/bo.conf?raw=True" -O /etc/nginx/sites-available/bo.conf
	
	if [ $? -eq 0 ]; then
		echo "Command Executed Successfully"
	else
		echo "Command Failed"
	fi
	
  	sudo chattr +i /etc/nginx/sites-available/lb.conf
	sudo chattr +i /etc/nginx/sites-available/bo.conf
	
	esperar "sleep 2" "Atualizando..." " ${WHITE} Atualizado!"

	reload "return" "menuNginx"
	pause
}

function showSubmenu2(){
	source config/submenus.sh
	sub-menu "menuNginx"
  reload "return" "menuNginx"
	pause
}

