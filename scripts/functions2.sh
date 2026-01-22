function globais(){
  #source config/config.sh
  version="1.0.0"
  WHITE="$(tput setaf 7)"
  CYAN="$(tput setaf 6)"
  MAGENTA="$(tput setaf 5)"
  YELLOW="$(tput setaf 3)"
  GREEN="$(tput setaf 2)"
  BLUE="$(tput setaf 4)"
  RED="$(tput setaf 1)"
  NORMAL="$(tput sgr0)"
  BOLD="$(tput bold)"
  tput init
}
function banner(){
  tput init
  data1=$1
  if [[ $data1 = *[[:digit:]]* ]]; then
    data1=$1
    sleep "$data1"
    var1=$2
    var2=$3
    var3=$4
  else
    var1=$1
    var2=$2
    var3=$3
  fi

  clear

  if [ -z "$var3" ]
  then
    echo -n "${GREEN}                                                         "
    echo -e "${BLUE}                       Version ${version}${YELLOW} Bash OnixSat 2024"
  else
    echo -n ""
    #printf "%100s |%s\n" ""
    #printf '%*s' $(tput cols) ""
    #tput cup $((LINES-2)) $((COLUMNS-4));echo "[OK]"
    #${BOLD}
    echo -e "${GREEN}Menu ${var1} ${BLUE}- ${YELLOW}${var2} ${GREEN}> ${BOLD}${RED}${var3}"
  fi

  echo -n "${NORMAL}"
  printf "%45s" " " | tr ' ' '-'
  echo -e "${NORMAL}"
  echo -n "${NORMAL}"
  tput init
}
function reload(){
  tput init
  data1=$1 data2=$2
	echo -n "Press Enter to $data1"
	read response
	loadMenu "$data2"
}
function loading(){
    EraseToEOL=$(tput el)
    max=$((SECONDS + 3))              # add 10 seconds to current count

    while [ $SECONDS -le ${max} ]
    do
        msg='Atualizando'
        for i in {1..4}
        do
            printf "%s" "${msg}"
            msg='.'
            sleep .2
        done
        printf "\r${EraseToEOL}"

    done
    echo -e "\\r${WHITE}Atualizado!"
    printf "\n"
}
function loading_icon(){

    local load_interval="${1}"
    local loading_message="${2}"
    local elapsed=0
    local loading_animation=( '—' "\\" '|' '/' )

    echo -n "${WHITE}${loading_message} "

    # This part is to make the cursor not blink on top of the animation while it lasts
    tput civis
    trap "tput cnorm" EXIT
    while [ "${load_interval}" -ne "${elapsed}" ]; do
        for frame in "${loading_animation[@]}" ; do
            printf "%s\b" "${frame}"
            sleep 0.25
        done
        elapsed=$(( elapsed + 1 ))
    done
    echo -e "\\r${WHITE}${CHECK_MARK} Atualizado!"
    printf " \b\n"

}
function clearLastLines(){
    local linesToClear=$1
    for (( i=0; i<linesToClear; i++ )); do
        tput cuu 1
        tput el
    done
}
function esperar(){
  # Executar e esperar
  # Run the command passed as 1st argument and shows the spinner until this is done
  # @param String $1 the command to run
  # @param String $2 the title to show next the spinner
  # @param var $3 the variable containing the return code
  CINZA="$(tput setaf 8)"
  CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"
  CHECK_SYMBOL='\u2713'
  X_SYMBOL='\u2A2F'
  local __resultvar=$3
  local msg=$2

  eval $1 >/tmp/execute-and-wait.log 2>&1 &
  pid=$!
  delay=0.05

  frames=('\u280B' '\u2819' '\u2839' '\u2838' '\u283C' '\u2834' '\u2826' '\u2827' '\u2807' '\u280F')

  echo "$pid" >"/tmp/.spinner.pid"

  tput civis # Hide the cursor, it looks ugly :D
  index=0
  framesCount=${#frames[@]}
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    printf "${YELLOW}${frames[$index]}${NC} ${GREEN}${msg}${NC}"

    let index=index+1
    if [ "$index" -ge "$framesCount" ]; then
      index=0
    fi

    printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
    sleep $delay
  done

  echo -e "\b\\r${CHECK_MARK}${CINZA} Atualizado!   "
echo -e ""
  #printf " \b\n"
  # Wait the command to be finished, this is needed to capture its exit status
  #wait $!
  #exitCode=$?
  #if [ "$exitCode" -eq "0" ]; then
  #  printf "${CHECK_SYMBOL} ${2}                                                                \b\n"
  #else
  #  printf "${X_SYMBOL} ${2}                                                                \b\n"
  #fi

  # Restore the cursor
  #tput cnorm
  #eval $__resultvar=$exitCode
}
function titulo(){
  tput init
  titulo=$1
  if [[ $titulo = *[[:digit:]]* ]]; then
    sleep "$titulo"
    titulo=$2
  fi

  echo "${BLUE}${titulo}${NORMAL}"

  tput init
}
function cores() {
    END=200
    for i in $(seq 0 $END); do
        echo "$i: `tput setaf $i`0123456789abcdef@`tput sgr0`"
        `tput setaf $i` 2>&1 | grep -Eo "\^\[\[[0-9]+m$"
    done
}
function encrypt() {
    # bash libs/encrypt.sh config/config.sh 12345 delete

    FILE=$1
    PASSPHRASE=$2
    SECURE_DELETE=$3
    ENCRYPTED_FILE="${FILE}.enc"

    # Encrypt the file
    openssl enc -aes-256-cbc -salt -pbkdf2 -iter 10000 -in "$FILE" -out "$ENCRYPTED_FILE" -pass pass:"$PASSPHRASE"

    if [ $? -eq 0 ]; then
        echo "File encrypted successfully: $ENCRYPTED_FILE"
    else
        echo "Encryption failed"
        exit 1
    fi

    # Securely delete the original file if requested
    if [ "$SECURE_DELETE" = "delete" ]; then
        # Overwrite the file with random data
        openssl rand -out "$FILE" $(stat --format=%s "$FILE")
        # Optionally, overwrite multiple times for extra security

        # Remove the file
        rm -f "$FILE"

        if [ $? -eq 0 ]; then
            echo "Original file securely deleted."
        else
            echo "Failed to securely delete the original file."
            exit 1
        fi
    fi
}
function decrypt() {
    #bash libs/decrypt.sh config/config.sh.enc 12345
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <file to decrypt> <passphrase>"
        exit 1
    fi

    ENCRYPTED_FILE=$1
    PASSPHRASE=$2
    DECRYPTED_FILE="${ENCRYPTED_FILE%.enc}"

    # Decrypt the file with PBKDF2 and the specified number of iterations
    openssl enc -aes-256-cbc -d -salt -pbkdf2 -iter 10000 -in "$ENCRYPTED_FILE" -out "$DECRYPTED_FILE" -pass pass:"$PASSPHRASE"

    if [ $? -eq 0 ]; then
        echo "File decrypted successfully: $DECRYPTED_FILE"
    else
        echo "Decryption failed"
        exit 1
    fi
}
function configs() {

    #!/bin/bash
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    #GUI=false; terminal=false # force relaunching as if launching from GUI without a GUI interface installed, but only do this for testing
    #NOSYMBOLS=true
    #NOCOLORS=true
    source "${SCRIPT_DIR}"/dialog.sh

    relaunch-if-not-visible
    APP_NAME="Configuração"

    ACTIVITY="Inquiry"
    yesno "Deseja configurar?";
    ANSWER=$?

    ACTIVITY="Response"
    if [ $ANSWER -eq 0 ]; then
      message-info "Vamos configurar."
    else
      message-warn "Terminado."
      exit
    fi
     password="Password+2024"
      sshport="2022"
      domain="encpro.pt"
      hostname="srv.encpro.pt"
      ns1="ns1.encpro.pt"
      ns2="ns2.encpro.pt"
      ip="135.125.183.142"

    ACTIVITY="Config"
    password=$(inputbox "What's your password?" "$password")
  INPUT=$(dialog --clear --backtitle "tt1" --title "tt2" --inputbox "${SYMBOL} $1" "$RECMD_LINES" "$RECMD_COLS" "$2" 3>&1 1>&2 2>&3)

    sshport=$(inputbox "What's your sshport?" "$sshport")
    domain=$(inputbox "What's your domain?" "$domain")
    hostname=$(inputbox "What's your hostname?" "$hostname")
    ns1=$(inputbox "What's your ns1?" "$ns1")
    ns2=$(inputbox "What's your ns2?" "$ns2")
    ip=$(inputbox "What's your ip?" "$ip")



    #$"Salvo:\n password: $password\n sshport: $sshport\n domain: $domain\n hostname: $hostname\n ns1: $ns1\n ns2: $ns2\n ip: $ip"

    ACTIVITY="Guardando..."
    {
    exec 3<> config/config.sh

        echo "#!/usr/bin/env bash" >&3
        echo "password='$password'" >&3
        echo "sshport='$sshport'" >&3
        echo "domain='$domain'" >&3
        echo "hostname='$hostname'" >&3
        echo "ns1='$ns1'" >&3
        echo "ns2='$ns2'" >&3
        echo "ip='$ip'" >&3

    exec 3>&-

      for ((i = 0 ; i <= 100 ; i+=5)); do
        # optional text during progress
        echo "1"
        if [[ "$((RANDOM % 2))" == "1" ]]; then
          SUB_ACTIVITY="Salvando..."
        else
          SUB_ACTIVITY=""
        fi

        progressbar_update "$i" "$SUB_ACTIVITY"
        sleep 0.2
      done
      progressbar_finish
    } | progressbar "$@"

    message-info "Salvo!"

}
function proteger() {
 globais
    # https://github.com/nodesocket/cryptr
    # CRYPTR_PASSWORD=A1EO7S9SsQYcPChOr47n cryptr encrypt ./config/config.sh
    # CRYPTR_PASSWORD=A1EO7S9SsQYcPChOr47n cryptr decrypt ./config/config.sh.aes

    if [ ! -d "cryptr" ]
    then
      titulo "Instalando cryptr..."
      git clone https://github.com/nodesocket/cryptr.git
      ln -s "$PWD"/cryptr/cryptr.bash /usr/local/bin/cryptr
      bash cryptr/tools/cryptr-bash-completion.bash
      esperar "sleep 10" "${WHITE}Instalado... "
    else

      file="config/config.sh.aes"
      if [[ ! -f "$file" && ! -s "$file" ]]; then
           # read -e -p "${MAGENTA}Senha:${NORMAL} " -i "12345" word
PET=$(whiptail --title "Test Free-form Input Box" --inputbox "What is your pet's name?" 10 60 Wigglebutt 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your pet name is:" $PET
else
    echo "You chose Cancel."
fi


#!/bin/bash
# yesnobox.sh - An inputbox demon shell script
OUTPUT="/tmp/input.txt"
# create empty file
>$OUTPUT
# Purpose - say hello to user
#  $1 -> name (set default to 'anonymous person')
function sayhello(){
	local n=${@-"anonymous person"}
	#display it
	dialog --title "Hello" --clear --msgbox "Hello ${n}, let us be friends!" 10 41
}
# cleanup  - add a trap that will remove $OUTPUT
# if any of the signals - SIGHUP SIGINT SIGTERM it received.
trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM
# show an inputbox






echo "kkk"
sleep 40


function display_output(){
local h=${1-10}                 # box height default 10
local w=${2-41}                 # box width default 41
local t=${3-Output}     # box title
  dialog --clear --backtitle "Descodificar ficheiro" --title "${t}" --inputbox "${SYMBOL} $(<$OUTPUT)" ${h} ${w} 3>&1 1>&2 2>&3
#  dialog --backtitle "tt1" --title "tt2" --inputbox "${SYMBOL} $1" "$RECMD_LINES" "$RECMD_COLS" "oi"
}
display_output 8 60 "Password"
echo "oi"
sleep 5
           answer=$( dialog --clear --backtitle "Proteger" --title "Encryptar" --inputbox "${SYMBOL} $1" "6" "60" "$2"3>&1 1>&2 2>&3)
             echo $answer

           #source libs/boxs.sh
echo "oi"
sleep 20
          decrypt config/config.sh.enc ${word}

          cryptr/cryptr.bash encrypt config/config.sh
          exit
      fi

      cryptr/cryptr.bash decrypt config/config.sh.aes

      data=$(<config/config.sh)
      tmpfile="$(mktemp /tmp/myscript.XXXXXX)"
      cat <<< "$data" > "$tmpfile"
          rm -f "config/config.sh"
          trap 'rm -f "$tmpfile"' SIGTERM SIGINT EXIT
      source "$tmpfile"
    fi
}
@confirm() {
  local message="$*"
  local result=3

  echo -n "> $message (y/n) " >&2

  while [[ $result -gt 1 ]] ; do
    read -s -n 1 choice
    case "$choice" in
      y|Y ) result=0 ;;
      n|N ) result=1 ;;
    esac
  done

  return $result
}
countdown(){
  cdx(){
    countdown && printf "%s\n" "DONE changing to "${1} # Gives out if return is 0 (${?})
  }
  spinner=(
  "Working    "
  "Working.   "
  "Working..  "
  "Working... "
  "Working...."
  )

  i=4

  if [ ${i} -lt 5 ]
  then
   while true
    do
     for i in ${i}
      do
       printf "%s    \t" ${spinner[i]}
       sleep .1
       printf "\r"
       sleep .1
       if [ ${i} -eq 0 ]
        then
         # Here you can clean up or do what to do at zero count
         printf "\n"
         unset i
         unset spinner
         return 0 # Can be used in ${?} from parent bash
       else
        i=$((${i}-1))
      fi
    done
   done
  return 1 # Should never be executed
  fi
}
all(){
  #echo -e "\\r${WHITE}${CHECK_MARK} Atualizado!"
  #banner 2 "Servidor" "Configuracão" "Password"
  #read -p "Continuando...." -t 5
  texto(){
    Comandos de modo de texto
    tput bold # Selecionar modo negrito
    tput dim # Selecionar modo de brilho reduzido
    tput smul # Ativar modo de sublinhado
    tput rmul # Desativar modo de sublinhado
    tput rev # Ativar modo de vídeo invertido
    tput smso # Entrar no modo destacado (negrito)
    tput rmso # Sair do modo destacado
    Comandos de movimentação de cursor
    tput cup Y X # Mover o cursor para a posição X,Y da tela (canto superior esquerdo é 0,0)
    tput cuf N # Mover N caracteres para frente (direita)
    tput cub N # Mover N caracteres para trás (esquerda)
    tput cuu N # Mover N linhas para cima
    tput ll # Mover para a última linha, primeira coluna (se não houver cup)
    tput sc # Salvar a posição do cursor
    tput rc # Restaurar a posição do cursor
    tput lines # Mostrar o número de linhas do terminal
    tput cols # Mostrar o número de colunas do terminal
    Comandos de limpeza e inserção
    tput ech N # Apagar N caracteres
    tput clear # Limpar a tela e mover o cursor para 0,0
    tput el 1 # Limpar até o início da linha
    tput el # Limpar até o final da linha
    tput ed # Limpar até o final da tela
    tput ich N # Inserir N caracteres (move o resto da linha para frente!)
    tput il N # Inserir N linhas
    Outros comandos
    tput sgr0 # Restaurar o formato de texto para o padrão do terminal
    tput bel # Emitir um sinal sonoro
  }
}
