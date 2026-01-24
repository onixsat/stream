#!/bin/sh
globais

read -r -d '' ENV_VAR_MENU << EOM
  Menu ${BLUE}- ${BOLD}${RED}Servidor${NORMAL}
EOM
createMenu "menuServidor" "$ENV_VAR_MENU"
addMenuItem "menuServidor" "Iniciar" showInativo "Iniciar"
addMenuItem "menuServidor" "Instalar" showInativo "Instalar"
addMenuItem "menuServidor" "Configuracao" loadMenu "menuConfig"

source menus/servidor/config.sh

function showInativo(){
	banner "Servidor" "$1" "Inátivo"
	esperar "sleep 2" "Verificando..." " ${WHITE} Esta opção está inátiva"
	reload "return" "menuServidor"
	pause
}

