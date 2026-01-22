#!/bin/bash
logo=(
"   ____                      _                __  __                   "
"  / ___|___  _ __  ___  ___ | | ___          |  \/  | ___ _ __  _   _  "
" | |   / _ \| '_ \/ __|/ _ \| |/ _ \  _____  | |\/| |/ _ \ '_ \| | | | "
" | |__| (_) | | | \__ \ (_) | |  __/ |_____| | |  | |  __/ | | | |_| | "
"  \____\___/|_| |_|___/\___/|_|\___|         |_|  |_|\___|_| |_|\__,_| "
"                                                                       "
)
function _spinner() {
    # $1 start/stop
    #
    # on start: $2 display message
    # on stop : $2 process exit status
    #           $3 spinner function pid (supplied from stop_spinner)

    local on_success="DONE"
    local on_fail="FAIL"
    local white="\e[1;37m"
    local green="\e[1;32m"
    local red="\e[1;31m"
    local nc="\e[0m"

    case $1 in
        start)
            # calculate the column where spinner and status msg will be displayed
            let column=$(tput cols)-${#2}-8
            # display message and position the cursor in $column column
            echo -ne ${2}
            printf "%${column}s"

            # start spinner
            i=1
            sp='\|/-'
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
                printf "\b${sp:i++%${#sp}:1}"
                sleep $delay
            done
            ;;
        stop)
            if [[ -z ${3} ]]; then
                echo "spinner is not running.."
                exit 1
            fi

            kill $3 > /dev/null 2>&1

            # inform the user uppon success or failure
            echo -en "\b["
            if [[ $2 -eq 0 ]]; then
                echo -en "${green}${on_success}${nc}"
            else
                echo -en "${red}${on_fail}${nc}"
            fi
            echo -e "]"
            ;;
        *)
            echo "invalid argument, try {start/stop}"
            exit 1
            ;;
    esac
}
function start_spinner {
    # $1 : msg to display
    _spinner "start" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    disown
}
function stop_spinner {
    # $1 : command exit status
    _spinner "stop" $1 $_sp_pid
    unset _sp_pid
}
menu=(
"Update"
"Password"
"Process Stats"
"Network Stats"
"Disk Stats"
"Exit"
)
# Off and on cursor
tput civis
trap ctrl_c INT
function ctrl_c() {
    tput cnorm
    clear
    return 1
    #reload "return" "$GLOBAL_VAR"
}

clear
selected=0

function show-menu {
    rows=$(tput lines)
    cols=$(tput cols)
    menu_length=${#menu[@]}
    current_row=$((rows / 2 - menu_length / 2))

    # logo
    for i in "${!logo[@]}"; do
        tput cup $current_row $((cols / 2 - ${#logo[$i]} / 2))
        echo "${logo[$i]}"
        ((current_row++))
    done

    # Menu
    for i in "${!menu[@]}"; do
        if [[ $i -eq $selected ]]; then
            tput cup $current_row $((cols / 2 - ${#menu[$i]} / 2))
            echo "> ${menu[$i]}"
        else
            tput cup $current_row $((cols / 2 - ${#menu[$i]} / 2))
            echo "  ${menu[$i]}"
        fi
        ((current_row++))
    done
}

function sub-menu {
    if [[ "$1" == "menuCpanel" ]]; then
        #echo "All is good ${1}"
        while true; do
                  show-menu
                  read -rsn1 key
                  case $key in
                      "")
                          clear
                          if [[ $selected -eq $(( ${#menu[@]} - 1 )) ]]; then # Exit
                              tput cnorm
                              break
                          else
                              line=${menu[$selected]}
                              # Main Code
                              if [ "$line" == "Menu1" ]
                                then
                                  echo "Menu 1"
                                  sleep 5
                              elif [ "$line" == "Process Stats" ]
                                  then
                                  ps=$(ps -Ao comm,user,cputime,pcpu,pmem,sz,rss,vsz,nlwp,psr,pri,ni)
                                  printf "%s\n" "${ps[@]}" | head -n 1
                                  printf "%s\n" "${ps[@]}" | sort -r -nk4 | head -n 20
                              elif [ "$line" == "Network Stats" ]
                                  then
                                  ss -t
                              elif [ "$line" == "Disk Stats" ]
                                  then
                                  lsblk -e7
                              fi
                              read -p "Press Enter to continue..."
                          fi
                          clear
                      ;;
                      # up
                      "A"|"a")
                          if [[ $selected -gt 0 ]]; then
                              selected=$((selected-1))
                          fi
                      ;;
                      "B"|"b")
                       # down
                          if [[ $selected -lt $(( ${#menu[@]} - 1 )) ]]; then
                              selected=$((selected+1))
                          fi
                      ;;
                  esac
              done
        #sleep 5
    elif [[ "$1" == "menuApache" ]]; then
        while true; do
                          show-menu
                          read -rsn1 key
                          case $key in
                              "")
                                  clear
                                  if [[ $selected -eq $(( ${#menu[@]} - 1 )) ]]; then # Exit
                                      tput cnorm
                                      break
                                  else
                                      line=${menu[$selected]}
                                      # Main Code
                                      if [ "$line" == "Update" ]
                                      then

                                          titulo "Atualizando o sistema..."

                                          function joinArray() {
                                              local delimiter="${1}"
                                              local output="${2}"
                                              for param in ${@:3}; do
                                                output="${output}${delimiter}${param}"
                                              done

                                              return "${output}"
                                          }
                                           join_strings () {
                                                declare separator="$1";
                                                declare -a args=("${@:2}");
                                                declare result;
                                                printf -v result '%s' "${args[@]/#/$separator}";
                                                printf '%s' "${result:${#separator}}"
                                            }

                                          declare -A myArray
                                            myArray[A]="yum update -y >> x1.txt"
                                            myArray[B]="ls config/ >> x1.txt"
                                            myArray[C]="yum upgrade -y >> x1.txt"
                                            myArray[D]="ip addr >> x1.txt"

                                          dados=$(join_strings ' && ' "${myArray[@]}")
                                          #echo $dados >> dados.txt
                                          esperar "$dados >> x2.txt" "${WHITE}Atualizando... " "Atualizado!"



                                        function app1(){
#                                          start_time2=$(date +%s%3N)

                                           start_loading "Atualizando..."
                                            sudo yum update -y >> a1.txt
                                            ls >> a1.txt
                                            mkdir delete >> a1.txt
                                            sudo yum upgrade -y >> a1.txt
                                            #> /dev/null 2>&1
                                           stop_loading $?

#                                          end_time2=$(date +%s%3N)
#                                          duration_ms2=$((end_time2 - start_time2))
#                                          echo "Execution: $duration_ms2"
                                        }

#app1
  #                                       # esperar "sleep 0" "${WHITE}Atualizando... " "Atualizado!"
                                          esperar app1 "${WHITE}Atualizando... " "Atualizado!" >> a2.txt

                                      elif [ "$line" == "Password" ]
                                      then
                                          titulo "Atualizando a password..."
                                          echo "${password}" | passwd --stdin root
                                          esperar "sleep 1" "${WHITE}Atualizando... "
                                      elif [ "$line" == "Process Stats" ]
                                          then
                                          ps=$(ps -Ao comm,user,cputime,pcpu,pmem,sz,rss,vsz,nlwp,psr,pri,ni)
                                          printf "%s\n" "${ps[@]}" | head -n 1
                                          printf "%s\n" "${ps[@]}" | sort -r -nk4 | head -n 20
                                      elif [ "$line" == "Network Stats" ]
                                          then
                                          ss -t
                                      elif [ "$line" == "Disk Stats" ]
                                          then
                                          lsblk -e7
                                      fi
                                      read -p "Press Enter to continue..."
                                  fi
                                  clear
                              ;;
                              # up
                              "A"|"a")
                                  if [[ $selected -gt 0 ]]; then
                                      selected=$((selected-1))
                                  fi
                              ;;
                              "B"|"b")
                               # down
                                  if [[ $selected -lt $(( ${#menu[@]} - 1 )) ]]; then
                                      selected=$((selected+1))
                                  fi
                              ;;
                          esac
                      done
    else
        return 1
    fi
}


if [[ $? -eq 0 ]]; then
    #echo rest of the script goes here
    #sleep 5
    function ctrl_c() {
        tput cnorm
        clear
        return 1
        #reload "return" "$GLOBAL_VAR"
    }
fi