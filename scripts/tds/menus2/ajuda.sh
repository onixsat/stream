#!/usr/bin/env bash

read -r -d '' ENV_CONFIG << EOM
  Main Menu
  - Ajuda
EOM
describe "Testing"
createMenu "menuAjuda" "$ENV_CONFIG"
addMenuItem "menuAjuda" "Ajuda 1" ajuda1
addMenuItem "menuAjuda" "Ajuda 2" ajuda2


script(){

	#Script para detecção de sub-dominios e ips de hosts e e html parsing
	if [ "$1" == "" ]
	then
		echo -e "Sem dados"
	else
	
	if [ ! -d logs ] 
	then
		mkdir -p logs
	fi
	
	if [[ ! -e logs/$1.html ]]; then
		touch logs/$1.html
	else
		truncate -s 0 logs/$1.html
		touch logs/$1.html
	fi
	
	if [[ ! -e logs/$1.txt ]]; then
		touch logs/$1.txt
	else
		truncate -s 0 logs/$1.txt
		touch logs/$1.txt
	fi

	
	
		echo -e "\033[32;94;5m
	#############################################################################
	- >                                 Ajuda                                 < -
	#############################################################################
		\033[m"
		echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: includes/$1                       
	-----------------------------------------------------------------------------
		\033[m"
		

			cp includes/$1.html logs/$1.html

#php -f config/convert.php includes/ajuda1.html> /dev/null 2>&1 &
php -f config/convert.php includes/ajuda1.html


			
			#grep "href" logs/$1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" | sort -u > logs/$1.txt2
			#sleep 1.00
			
		lynx logs/$1.html
			echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em logs/$1.txt                       
	-----------------------------------------------------------------------------
		\033[m"
	fi

#	for hst in $(cat logs/$1.txt);
#	do
#		host $hst | grep "has address" |  sed 's/has address/54.38.191.102/' | column -t;
		# sed 's/has address/\tIP:/' | column -t -s ' ';
		# sed 's/has address/<< IP >>/' | column -t;
#	done
}

function ajuda1() {

	read -e -p "Ver ajuda:" -i "ajuda1" vip
	script $vip
	
	tput init
	pause

}
function ajuda2() {
	read -e -p "Ver ajuda:" -i "ajuda2" vip
	script $vip
	pause
}


