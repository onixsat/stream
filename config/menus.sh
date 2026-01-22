#!/bin/bash
HEADER_MSG="Bash Ubuntu"

createMenu "mainMenu" "Main Menu"
addMenuItem "mainMenu" "Servidor" loadMenu "menuServidor"
addMenuItem "mainMenu" "Nginx" loadMenu "menuNginx"
addMenuItem "mainMenu" "DNS" loadMenu "menuDns"
addMenuItem "mainMenu" "Quit" l8r

source menus/servidor.sh
source menus/nginx.sh
source menus/dns.sh
