#!/usr/bin/env bash

read -r -d '' ENV_CONFIG << EOM
  Main Menu
  - Verificar
EOM
describe "Testing"
createMenu "menuVerificar" "$ENV_CONFIG"
addMenuItem "menuVerificar" "Verificar" showVerificar
addMenuItem "menuVerificar" "Verificar 2" showVerificar2

printMenuStrs "menuVerificar"

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
		
#realpath *.html | xargs --max-lines=1 lynx
			cp includes/$1.html logs/$1.html

#php -f config/convert.php includes/ajuda1.html> /dev/null 2>&1 &
#php -f config/convert.php includes/verificar.html
php -f config/convert.php includes/$1.html

			
			#grep "href" logs/$1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" | sort -u > logs/$1.txt2
			#sleep 1.00
			
		lynx logs/$1.html
		#-accept_all_cookies http://172.27.217.133//var/www/html/instalar/includes/
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


function showVerificar() {

  read -e -p "Ver:" -i "verificar" vip
	script $vip
	
	tput init
	pause

}
function showVerificar2() {

  read -e -p "Ver:" -i "verificar2" vip
	script $vip

	tput init
	pause

}
