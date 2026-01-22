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
		echo -e "\033[32;94;5m
	#############################################################################
	- >                                 Ajuda                                 < -
	#############################################################################
		\033[m"
		echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: $1                       
	-----------------------------------------------------------------------------
		\033[m"
		
			#wget -q $1 -O $1.html
			cp ajuda/$1.html $1.html
			grep "href" $1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" |sort -u |sed "s/'/ /" > $1.txt
			sleep 1.00
			
		lynx $1.html
			echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em $1.txt                       
	-----------------------------------------------------------------------------
		\033[m"
			echo -e "\033[31;94;2m
	_____________________________________________________________________________
	 [+] Identificando o ip                                                     
	-----------------------------------------------------------------------------
		\033[m"
#		banner 5
	fi

	for hst in $(cat $1.txt);
	do
		host $hst | grep "has address" |sed 's/has address/\tIP:/' | column -t -s ' ';
		# sed 's/has address/<< IP >>/' | column -t;
		echo ""
	done
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



