#!/usr/bin/env bash

read -r -d '' ENV_VAR_MENU << EOM
  Menu ${BLUE}Servidor - ${BOLD}${RED}Configuracão${NORMAL}
EOM
 createMenu "menuConfig" "$ENV_VAR_MENU"
 printMenuStrs "menuConfig"
 addMenuItem "menuConfig" "Informacoes" generalsCommands
 addMenuItem "menuConfig" "DNS" outer
 addMenuItem "menuConfig" "Mail" mailMenu
 addMenuItem "menuConfig" "Sobre" loadMenu "subMenu"
 addMenuItem "menuConfig" "Go back" loadMenu "menuServidor"
#loadMenu "menuConfig"
#pause

read -r -d '' ENV_CONFIG222 << EOM
  Menu ${BLUE}Servidor - ${BOLD}${RED}Sobre${NORMAL}
EOM
createMenu "subMenu" "$ENV_CONFIG222"

printMenuStrs "subMenu"
printMenuStrs "menuConfig"
addMenuItem "subMenu" "Go back" loadMenu "menuConfig"

reload(){
data1=$1 data2=$2
	echo -n "Press Enter to $data1"
	read response
    loadMenu "$data2"
}
linearSearch (){
filename="${1}" # $1 represent first argument




 if [ -e "$filename" ]; then
    content=$(cat "$filename")
    echo -e "$content"
	return 0
else
    echo "File not found: $filename"
fi
    return 1
}
getTime(){

	time=$(date +"%T")
	echo "La hora es: $time"
	reload "return" "menuConfig2"
	pause

}
getCurrentPath(){
	path=$(pwd)
	echo "Tu estas en: $path"
	reload "return" "menuConfig2"
	pause
}
generalsCommands(){

read -r -d '' ENV_CONFIG << EOM
 Menu ${BLUE}Servidor - ${BOLD}${RED}Informacoes${NORMAL}
EOM

createMenu "menuConfig2" "$ENV_CONFIG"
printMenuStrs "menuConfig2"
addMenuItem "menuConfig2" "getTime" getTime
addMenuItem "menuConfig2" "getCurrentPath" getCurrentPath
addMenuItem "menuConfig2" "Go back" 'loadMenu "menuConfig"'

    loadMenu "menuConfig2"
    #reload "return" "menuConfig"
	pause
}
mailMenu(){
whiptail --title "Configurar na OVH" --msgbox "135.125.183.142 srv.encpro.pt. \n141.95.110.219 mail.encpro.pt." 8 78
whiptail \
    --backtitle "Cloudflare" \
    --title "Configurar na Cloudflare" \
    --textbox "scripts/cloudflare.txt" 36 96 \
    --scrolltext



setHostname() {
		whiptail --msgbox
	"Please note:\n\n \
	\nhostname's labels may contain only the ASCII letters from 'a' to 'z' (case-insensitive), the digits from '0' to '9', and the hypen '-'.\
	\nHostname labels cannot begin or end with a hypen '-'. \
	\nNO OTHER SYMBOLS, punctuation characters, or blank spaces are permitted.\
		" 20 70 1
		CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
		NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$CURRENT_HOSTNAME" 3>&1 1>&2 2>&3)

		if [ $? -eq 0 ];
		then
			echo $NEW_HOSTNAME > /etc/hostname
			sudo sed -i "s/127.0.0.1.*$CURRENT_HOSTNAME/127.0.0.1\t$NEW_HOSTNAME/g" /etc/hosts

			if [ $? -eq 0 ]; then
				whiptail --msgbox "Hostname changed succesfull." 20 70 1
			else
				whiptail --msgbox "Something went wrong. Try again." 20 70 1
			fi
		fi
		goToMainMenu
	}
setHostname


read -r -d '' ENV_CONFIG << EOM
  Menu ${BLUE}Servidor - ${BOLD}${RED}Mail${NORMAL}
EOM

createMenu "menuConfig3" "$ENV_CONFIG"
printMenuStrs "menuConfig3"
addMenuItem "menuConfig3" "showMailip" showMailip
addMenuItem "menuConfig3" "showMailhelo" showMailhelo
addMenuItem "menuConfig3" "Update IP" showMailUpdate
addMenuItem "menuConfig3" "Go back" 'loadMenu "menuConfig"'

    loadMenu "menuConfig3"

}
function outer() {

	Pre() {
		Debug_Log2 "Setting"
		Line_Number=$(grep -n "127.0.0.1" /etc/hosts | cut -d: -f 1)
		My_Hostname=$(hostname)

		if [[ -n $Line_Number ]]; then
		  for Line_Number2 in $Line_Number ; do
			String=$(sed "${Line_Number2}q;d" /etc/hosts)
			if [[ $String != *"$My_Hostname"* ]]; then
			  New_String="$String $My_Hostname"
			  sed -i "${Line_Number2}s/.*/${New_String}/" /etc/hosts
			fi
		  done
		else
		  echo "127.0.0.1 $My_Hostname " >>/etc/hosts
		fi

	}

	Check_Root() {
		while true; do
		  echo -e "\nHostnames:"
		  echo "1. Editar"
		  echo "2. $srv"

		  read -p "Enter your choice (1 or 2): " choice

		  case $choice in
			1)
			  echo "Escreva"
			  read -p "New Hostname: " srv
			  continua=true
			  break
			  ;;
			2)
		#  echo -e "New Hostname: $srv"
			  continua=true
			  break
			  ;;
			*)
			  echo -e "Invalid choice. Please choose 1 or 2."
			  ;;
		  esac
		done

	}
    inner() {

hn=$1 srv=$2
/bin/sed -i -- 's/'"$hn"'/'"$srv"'/g' /etc/hosts
/bin/sed -i -- 's/'"$hn"'/'"$srv"'/g' /etc/hostname
hostnamectl set-hostname $srv
hostnamectl set-hostname "crowncloud production server" --pretty
printf "Changing Hostname: "
linearSearch "/etc/hostname"
printf "Changing Hosts:\n"
linearSearch "/etc/hosts"

cp /etc/resolv.conf /etc/resolv.conf_bak
rm -f /etc/resolv.conf


if [ -n "$nameserver" ]; then
  echo -e "nameserver ${nameserver[0]}" > /etc/resolv.conf
  echo -e "nameserver ${nameserver[1]}" >> /etc/resolv.conf
else
  echo -e "nameserver 1.1.1.1" > /etc/resolv.conf
  echo -e "nameserver 8.8.8.8" >> /etc/resolv.conf
fi

	printf "\nNovo /etc/resolv.conf:\n"
	  linearSearch "/etc/resolv.conf"

    }

nameserver=("8.8.8.8" "8.8.4.4")
srv="srv.${domain}"
	hn=$(/bin/hostname)
	#hn=$(hostname -f)
	#hn="vps-98e038c0.vps.ovh.net"
	echo Current Hostname: $hn

	Check_Root
	inner $hn $srv

	if [ "$continua" = true ]; then
    echo -e "The Boolean is true\n\n"

		echo -n "Press Enter to return to menu config"
		read response
    reload "config" "menuConfig"


	  else
	  printf "lol\n\n"
	  fi

	  pause
}
function showMailip() {
        echo "Mailip!"

		TARGET_FILE="/etc/mailips"

		if [[ -f "$TARGET_FILE" ]]
		then
			echo "$TARGET_FILE exists."

				echo -n '' > $TARGET_FILE
				wc -c $TARGET_FILE
				echo "" > $TARGET_FILE
				truncate -s 0 $TARGET_FILE

		else
			echo "$TARGET_FILE does not exist."
		fi


        touch $TARGET_FILE
        echo "${domain}: ${ip}" > $TARGET_FILE
        echo "mail.${domain}: ${ip}" >> $TARGET_FILE
        echo "*: ${dns}" >> $TARGET_FILE

        reload "return" "menuConfig3"
        pause
}
function showMailhelo() {
        echo "Mailhelo!"

		TARGET_FILE="/etc/mailhelo"

		if [[ -f "$TARGET_FILE" ]]
		then
			echo "$TARGET_FILE exists."

				echo -n '' > $TARGET_FILE
				wc -c $TARGET_FILE
				echo "" > $TARGET_FILE
				truncate -s 0 $TARGET_FILE

		else
			echo "$TARGET_FILE does not exist."
		fi


        touch $TARGET_FILE
        echo "${domain}: mail.${domain}" > $TARGET_FILE
        echo "mail.${domain}: mail.${domain}" >> $TARGET_FILE
        echo "*: srv.${domain}" >> $TARGET_FILE

        reload "return" "menuConfig3"
        pause
}
function showMailUpdate(){
    local ret_val=nothing
    echo $ret_val
    func1
    echo $ret_val
    func2
    echo $ret_val


y="${ip}"
x='XYZ'
sed -i -e 's/$x/$y/g' /etc/mailips
#or,
sed -i -e "s/$x/$y/g" /etc/mailips

pause
}

func1(){
ret_val="f1"
}
func2(){
ret_val="f2"
#pause
}