#!/bin/bash

cd /var/www/html/instalar/
#ls
exit
####used to debug:
#export DIR=/var/www/html/instalar/
#echo $DIR
export "PATH=$PATH:$HOME/instalar"
PATH=$(./btk.sh)

echo $PATH
exit
echo "${#} Parameters"
echo "${1} is first"

if [ $# -eq 0 ]
then
echo "Login parameter not provided!"
else
lynx -cmd_script=$1 -accept_all_cookies http://www.theurl.com
fi