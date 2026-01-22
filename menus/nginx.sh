#!/bin/sh
globais

read -r -d '' ENV_VAR_MENU << EOM
  ${BLUE}Menu Nginx - ${BOLD}${RED}Configuracão${NORMAL}
EOM
createMenu "menuNginx" "$ENV_VAR_MENU"
addMenuItem "menuNginx" "Sub Menu" showSubmenu

function showSubmenu(){
  source config/submenus.sh
	sub-menu "menuNginx"
	reload "return" "menuNginx"
	pause
}