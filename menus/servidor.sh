#!/bin/sh
globais

read -r -d '' ENV_VAR_MENU << EOM
  Menu ${BLUE}- ${BOLD}${RED}Servidor${NORMAL}
EOM
createMenu "menuServidor" "$ENV_VAR_MENU"
addMenuItem "menuServidor" "Iniciar" showIniciar
addMenuItem "menuServidor" "Instalar" showInstalar
addMenuItem "menuServidor" "Configuracao" loadMenu "menuConfig"

source menus/servidor/config.sh

function showIniciar(){
	banner "Servidor" "Configuracão" "Iniciar"
echo ${domain}
	if @confirm 'Confirma que quer atualizar?' ; then
    source menus/servidor/iniciar.sh
  else
    echo "No"
  fi

	reload "return" "menuServidor"
	pause
}

function showInstalar(){
	banner "Servidor" "Configuracão" "Instalar"
	echo "sem app"
	#source scripts/iniciar.sh

	reload "return" "menuServidor"
	pause
}
