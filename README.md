<div align="center">
  <a href="https://onixsat">
    <img src="scripts/logo.png" alt="Logo" width="300">
  </a>
  <img src="scripts/waves.svg" width="100%" height="100">
  <a id="readme-top"></a>
</div>
<details>
  <summary>Menu de NevegaÃ§Ã£o</summary>
  <ol>
    <li><a href="#INSTALAR">InstalaÃ§Ã£o</a></li>
    <li><a href="#PASSWORDS">Passwords</a></li>
    <li>
      <a href="#CODIGOS">CÃ³digos</a>
      <ul>
          <li><a href="#CMDS">Comandos</a></li>
        <li><a href="#BLOQUEAR">Bloquear</a></li>
        <li><a href="#OUTROS">Outros</a></li>
        <li><a href="#CARREGAR">Carregar</a></li>
      </ul>
    </li>
    <li><a href="#CONTATOS">Contatos</a></li>
  </ol>
</details>

<div id="INSTALAR">

<h2 style="font-style:italic;">ðŸ› ï¸ InstalaÃ§Ã£o</h2>
<h6 style="font-style:italic;">Executar os comandos para instalar o sistema.</h6>

```bash
  sudo su
  sudo yum update -y
  sudo yum install -y git nano wget
  git clone https://github.com/onixsat/stream.git
  cd stream
  bash btk.sh
 ```

<sm style="font-style:italic;">
  Ao iniciar vai criar o ficheiro de configuraÃ§Ã£o seguro em <a href="config/config.sh.enc">config/config.sh.enc</a>
  <br>
  Ao iniciar novamente digite a sua password para desencriptar o ficheiro seguro localmente e iniciar o programa.
  <br>
  
  _Nota: O arquivo descodificado serÃ¡ eliminado da maquina local quando desligar o terminal._

</sm>

</div>

<details id="PASSWORDS">
  <summary><h4 style="font-style:italic;">ðŸ“« Default Passwords</h4></summary>

*Passwords padrÃ£o na configuraÃ§Ã£o do sistema.*

<sub>[ [SSH](root) Username: $\textcolor{green}{\textsf{root}}\$ ]  $\textcolor{cyan}{\textsf{Password+2024}}$</sub>\
<sup>[ [EncriptaÃ§Ã£o](root) $\textcolor{green}{\textsf{Sistema}}\$ ] $\textcolor{cyan}{\textsf{12345}}$</sup>
</details>

<details id="CODIGOS">
  <summary><h2 style="font-style:italic;">ðŸš€ CÃ³digos</h2></summary>

_CÃ³digos de script bÃ¡sicos para utilizaÃ£o na shell linux._

<div id="BLOQUEAR">

* __Bloquear__\
  *Bloquear alteraÃ§Ã£o de ficheiros*

  ```bash
  chattr -i /etc/mailips
  chattr -i /etc/mailhelo
  chattr +i /etc/mailips
  chattr +i /etc/mailhelo
  ```

</div>

<div id="OUTROS">

* __Outros__
  ```bash
    banner "Apache" "ConfiguracÃ£o" "Password"
    titulo "Atualizando o sistema..."

    declare -A myArray
      myArray[A]="yum update -y"
      myArray[B]="hostname>h.txt"
      
    dados=$(jstrings ' && ' "${myArray[@]}")
    esperar "$dados" "${WHITE}Atualizando..." "Atualizado!"
  ```

</div>

<div id="CARREGAR">

* __Carregar__
  ```bash
  function carregar(){
    start_time2=$(date +%s%3N)
    start_loading "Carregando..."
    sleep 5
    stop_loading $?
    end_time2=$(date +%s%3N)
    duration_ms2=$((end_time2 - start_time2))
    echo "Execution: $duration_ms2"
  }

  esperar carregar "${WHITE}Carregando..." "Carregado!"
  ```

</div>

</details>

<details id="OUTROS">
  <summary><h2 style="font-style:italic;">Outros</h2></summary>




_CÃ³digos de script bÃ¡sicos para utilizaÃ£o na shell linux._
---

<div id="CMDS">
Primeiro

``` Iniciar
git clone https://github.com/onixsat/stream.git
sudo apt-get update
sudo apt-get install dos2unix
cd ..
dos2unix stream/*
cd stream/
bash btk.sh
find -name '*.sh' -print0 | xargs -0 dos2unix
nano libs/functions.sh
nano btk.log
nano btk.sh
rm btk.log
nano config/config.sh
nano config/config.sh.enc
nano config/menus.sh
nano menus/servidor/config.sh
cc
ccc
nano menus/servidor.sh
rm menus/servidor/config.sh
rm menus/servidor/iniciar.sh
nano menus/dns.sh
rm menus/dns.sh
ls
rm dns_2026-01-22.log
nano oi
rm oi
clear
rm menus/nginx.sh
nano menus/nginx.sh
rm config/submenus.sh
nano config/submenus.sh
nano cnf1.txt
sudo nginx -t
nginx -t
sudo apt install nginx-full
nano oi.php
rm libs/functions.sh
rm config/config.sh.enc
nano config/
rm cnf1.txt
rm oi.php
rm config/config.sh
sudo apt-get install iptables-persistent
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
localhost
ping
ping 0.0.0.0
hostname
sudo apt update
sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx Full'
sudo ufw enable
sudo ufw status
sudo apt-get purge --auto-remove ufw
sudo apt-get install ufw
hostname -I
sudo nano /etc/nginx/sites-available/default
sudo iptables -A PREROUTING -t nat -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo systemctl reload nginx
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo systemctl restart nginx
cd /etc/nginx/sites-available/
cp default default2
sudo cp default default2
rm default
sudo rm default
nano default
nano default2
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d DESKTOP-3D1ERD0
sudo nano default
nano /etc/hostname
sudo nano /etc/hostname
nano /etc/hosts
ipconfig
ifconfig
sudo apt install net-tools
sudo nano /etc/hosts
sudo certbot --nginx -d srv.onixsat.online
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo apt install -y certbot python3-certbot-nginx
sudo ufw delete allow 'Nginx HTTP'
sudo certbot --nginx -d localhost
sudo certbot --nginx
sudo certbot certonly --nginx
mkcert example.com
mkcert -install
apt-get install mkcert
sudo apt-get install mkcert
sudo mkcert example.com
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.2/mkcert-v1.4.2-linux-amd64
mv mkcert-v1.4.2-linux-amd64 mkcert
chmod +x mkcert
cp mkcert /usr/local/bin/
sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.2/mkcert-v1.4.2-linux-amd64
sudo mv mkcert-v1.4.2-linux-amd64 mkcert
sudo cp mkcert /usr/local/bin/
sudo mkcert -install
a2enmod ssl
sudo apt install apache2
a2ensite default-ssl.conf
sudo a2ensite default-ssl.conf
sudo   systemctl reload apache2
nano  /usr/local/share/ca-certificates/
sudo update-ca-certificates
nano /etc/letsencrypt/csr/0000_csr-certbot.pem
nano /etc/letsencrypt/ssl-dhparams.pem
sudo iptables -A PREROUTING -t nat -p tcp --dport 8080 -j REDIRECT --to-port 80
quit
exit
printf "\e]66;s=2;Double sized text\a\n\n"
printf "\e]66;s=3;Triple sized text\a\n\n\n"
printf "\e]66;n=1:d=2;Half sized text\a\n
printf "\e]66;n=1:d=2;Half sized text\a\n"
print "\e]66;n=1:d=2;Half sized text\a\n"
echo "\e]66;n=1:d=2;Half sized text\a\n"
sgr0
tput rev;   echo "This text has the reverse attribute";   tput sgr0
banner "BIG TEXT"
banner "ONIXSAT Pro"
banner "ONIXSAT PRO"
banner "ONIXSAT"
banner "ONIXSAT ©"
banner "ONIXSAT©"
banner "ONIXSATbol ©"
sudo
sudo su
SHELLCHECK_VERSION=$(curl -s "https://api.github.com/repos/koalaman/shellcheck/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
wget -qO shellcheck.tar.xz https://github.com/koalaman/shellcheck/releases/latest/download/shellcheck-v$SHELLCHECK_VERSION.linux.x86_64.tar.xz
mkdir shellcheck-temp
tar xf shellcheck.tar.xz --strip-components=1 -C shellcheck-temp
sudo mv shellcheck-temp/shellcheck /usr/local/bin
shellcheck --version
rm -rf shellcheck.tar.xz shellcheck-temp
nano test.sh
shellcheck test.sh
bash test.sh
shellcheck btk.sh
shellcheck config/menus.sh
shellcheck config/menus.sh  -x
shellcheck config/submenus.sh  -x
shellcheck menus/nginx.sh
bash -n btk.sh
bash -n ./btk.sh
shellcheck *.sh
nano bash btk.sh
rm test.sh
nano file.log
rm file.log
nano  flog.lo
rm flog.log
nano log.log
rm log.log
rm log.log nna
cd wsl
cd home/
cd onixsat/stream/
localhost:
nano ver.log
rm btkrmkk
rm btkl
lc
rm notify.log
rm ver.log
[A[B
nano mmm.log
password
assw
asswor
nano a.sh
bash a.sh
sudo lsof -t -i tcp:8000 -s tcp:listen
sudo lsof -t -i tcp:8089 -s tcp:listen
sudo lsof -t -i tcp -s tcp:listen
sudo lsof tcp:listen
sudo lsof
lsof
lsof -i -sTCP:ESTABLISHED
lsof -i -sTCP
lsof -i -s TCP:ESTABLISHED
lsof -i -s tcp:ESTABLISHED
lsof -i -s tcp
sudo lsof -nP -iTCP -sTCP:LISTEN
lsof -nP -iTCP -sTCP:LISTEN
sudo netstat -tunpl
netstat -tunpl
lsof -nP -iTCP -sTCP:LISTEN | sudo xargs kill
lsof -nP -iTCP -sTCP:LISTEN | xargs kill
lsof -t -i tcp:8000 -s tcp:listen | sudo xargs kill
lsof -t -i tcp:8000 -s tcp:listen | xargs kill
lsof -nP -iTCP -sTCP:LISTEN | KILL
lsof -nP -iTCP -sTCP:LISTEN | xargs --no-run-if-empty kill -9
lsof -nP -iTCP -sTCP:LISTEN | sudo xargs --no-run-if-empty kill -9
lsof -nP -iTCP -sTCP:LISTEN | xargs kill -9
lsof -t -nP -iTCP -sTCP:LISTEN | xargs kill -9
lsof -t -nP -iTCP -sTCP:LISTEN
nano v.sh
bash v.sh
nano b.sh
bash b.sh
nano m.sh
bash m.sh
nano c.sh
bash c.sh
nano o.sh
bash o.sh
git clone https://github.com/Adewagold/nginx-server-manager.git
cd nginx-server-manager
chmod +x install.sh
./install.sh
sudo./install.sh
sudo install.sh
sudo bash install.sh
sudo ./install.sh
su ./install.sh
sudo bash ./install.sh
python -v
python3 -v
python2 -v
sudo systemctl start nginx-manager
sudo apt install -y nginx python3 python3-pip python3-venv certbot python3-certbot-nginx
sudo apt install -y nginx python3
sudo apt install -y python3
sudo install -y python3
sudo apt-get install -y python3
sudo apt-get install python3
sudo apt-get install python
python3
sudo apt-get remove python3
sudo apt-get remove python3.8
sudo apt-get remove python
ls /usr/bin/python*
apt-get remove python3.8
py -v
sudo apt remove python3.12 -y
sudo apt remove python3 -y
sudo apt remove --purge python3 -y
sudo killall apt apt-get
sudo killall apt
sudo killall python3
sudo killall python
sudo killall python3.8
sudo killall python3.5
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
sudo apt remove python3.8 -y
sudo dpkg --configure -a
sudo apt remove python2 -y
sudo apt remove python -y
sudo rm /var/lib/dpkg/lock
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
nano requirements.txt
pip install 'pydantic&lt;2'
pip install -U pydantic
pip install -U pydantic-settings
sudo chattr -i /etc/nginx/sites-available/lb.conf
sudo chattr -i /etc/nginx/sites-available/bo.conf
nano config.yaml
sudo systemctl status nginx-manager
sudo systemctl stop nginx-manager
cd nginx-server-manager/
wget https://gist.githubusercontent.com/Dryam/3cd2e55a19e1954f1433/raw/1ade54d8947afd2c875768b69b3b6ce19b66cf2b/nps_install.sh
bash nps_install.sh
nano nps_install.sh
nano /usr/local/nginx/conf/nginx.conf
nano /etc/nginx/nginx.conf
nano /etc/nginx/sites-enabled/default
nano /etc/nginx/sites-available/default
nano /etc/nginx/
npm install -g nginx-domain-assist
git clone https://github.com/muthuishere/nginx-domain-assist.git
cd nginx-domain-assist/
nano /etc/apache2/sites-available/000-default.conf
nano /var/www/html/index.html
nano C:\Windows\System32\drivers\etc\hosts
netsh interface portproxy show v4tov4
wsl hostname -I
nano /etc/resolv.conf
sudo nano /etc/resolv.conf
git clone https://gist.github.com/2166392.git
sudo  certbot --nginx -d onixsat.online
sudo nano /etc/nginx/nginx.conf
systemctl restart nginx
/usr/local/nginx/sbin/nginx -s  reload
systemctl start nginx
sudo systemctl start nginx
sudo netstat -tulpn
sudo fuser -k 80/tcp
sudo fuser -k 443/tcp
udo /etc/init.d/apache2 stop
nginx -t -c /etc/nginx/nginx.conf
systemctl stop apache2
systemctl status apache2
systemctl status nginx
sudo killall nginx
sudo killall apache2
sudo killall apache
nano /var/www/html/index.nginx-debian.html
sudo nginx -s reload
sudo ufw allow OpenSSH
sudo apt install ufw
sudo ufw allow ssh
sudo ufw status numbered
cp /etc/nginx/sites-enabled/default default
rm /etc/nginx/sites-enabled/default
localip=$(hostname  -I | cut -f1 -d' ')
echo $localip
nano /etc/nginx/sites-available/myproject.conf
ln -s /etc/nginx/sites-available/myproject.conf /etc/nginx/sites-enabled/myproject.conf
systemctl daemon-reload
sudo systemctl daemon-reload
cd /var/www/html/
sudo service apache2 stop
service nginx restart
sudo fuser -k 8080/tcp
sudo systemctl stop nginx
sudo killall nginx-manager
sudo killall httpd
sudo killall http
sudo killall tcp
service nginx start
nginx.service nginx start
nginx.service start
sudo service nginx start
sudo service nginx stop
nano /etc/nginx/sites-enabled/myproject.conf
sudo rm /etc/nginx/nginx.conf
apt-get purge nginx nginx-common nginx-full
sudo dpkg-reconfigure nginx
purge
sudo apt-get purge nginx nginx-common nginx-full
sudo apt-get install nginx
sudo dpkg --force-confmiss -i /var/cache/apt/archives/nginx-common_*.deb
apt-get update
sudo install nginx
rm -rf /etc/nginx
```
</div>
-----------------------------------




## recursive WP file & folder permissions fix
find /home/*/public_html -type d -exec chmod 755 {} \;\
find /home/*/public_html -type f -exec chmod 644 {} \;


chown -R nobody /home/project/ \
chown -R project /home/project/







Primeiro

``` Iniciar
cd /home
git clone https://github.com/onixsat/almalinux8.git
cd almalinux8
bash btk.sh

wget https://raw.githubusercontent.com/onixsat/almalinux8/refs/heads/main/scripts/iniciar.sh -O ./iniciar.sh && bash iniciar.sh
```
-----------------------------------
sudo chmod +x ~/virtualhost
https://raw.githubusercontent.com/onixsat/almalinux8/refs/heads/main/scripts/install_cpanel.sh

echo "Install php..."
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install php7.4 php7.4-dev php7.4-cli libapache2-mod-php7.4 php7.4-common php7.4-mbstring php7.4-xmlrpc php7.4-soap php7.4-gd php7.4-xml php7.4-intl php7.4-mysql php7.4-cli php7.4-zip php7.4-curl -y

hostnamectl set-hostname my.new-hostname.server
hostnamectl
nano /etc/hosts
cd etc/sysconfig/network-scripts/

---------------------- PRIMEIRO

curl -s -L https://www.alphagnu.com/upload/centos7-repo-fix.sh | bash
yum install wget nano net-tools -y
yum -y update
yum -y upgrade
yum install epel-release
yum install nginx

#wget https://raw.githubusercontent.com/zpanel/installers/refs/heads/master/install/beta/CentOS_7/beta-Centos-7-10.1.1.sh

---------------------- SEGUNDO

    ip addr
    hostname
    nano /etc/hosts
    nano /etc/hostname 
    ping onixsat.line.pm
    ifconfig
ip addr show enp0s3 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
sudo systemctl enable httpd.service
sudo yum install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb.service
sudo systemctl status mariadb
sudo yum install php php-mysql
sudo systemctl restart httpd.service
php -v
sudo chown -R root.root /var/www/html/ #sammy is exmple. user

nano /var/www/html/nano a.sh
bash a.sh
ip addr
cd /var/www/html/
nano index.php


---------------------- TERCEIRO

nano C:\Windows\System32\drivers\etc\hosts
192.168.1.95	onixsat.line.pm
46.189.234.37 	onixsat.line.pm


---------------------- QUARTO


https://freedomain.one
onixsat.line.pm

----------------------------------
https://www.youtube.com/watch?v=MZ7n0MeQvGU

curl -s -L https://www.alphagnu.com/upload/centos7-repo-fix.sh | bash
https://gitsang.github.io/docs/linux/install_php74_on_centos7/
https://gist.github.com/Henriquedn/a93f058be4965d2cd6b61a1d0e3cfd1e
https://github.com/mahmudtopu3/Deploy-PHP-Laravel-Application-on-Linux-Centos-7-VPS-Server-Guidelines-
https://www.linuxhelp.com/how-to-install-phpvirtualbox-in-centos-manage-virtualbox#!#google_vignette~
https://gist.github.com/virbo/71776c0a7f3c1442147eb9f5b4306af5
https://raw.githubusercontent.com/mdichirico/public-shell-scripts/master/setup-lamp-stack-on-cent-os-7.sh
https://gist.github.com/nunorbatista/919d8e888115930cebe2
https://gist.github.com/rajibbinalam/3265bf0e9878daedf2ce36d0b8769fad
https://gist.github.com/RatserX/b67ac5dc24e05ee6747950f40d232e7b



yum -y install wget zip unzip net-tools yum-utils
yum install httpd mysql-server php php-mysql

chkconfig httpd on
chkconfig mysqld on

systemctl stop firewalld
systemctl mask firewalld
yum install iptables-services -y
nano /etc/sysconfig/iptables

A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
A INPUT -m state --state NEW -m tcp -p tcp --match multiport --dports 80,443,3306 -j ACCEPT

systemctl enable iptables
systemctl restart iptables

ðŸš€ðŸ› ï¸ðŸ“«


<a href="[link]">[link]</a>
[logo]: scripts/logo.png
[link](https://www.example.com/my%20great%20page "lol")

Document in [MSON][].
[MSON]: https://google.com

</details>
<div align="center" id="CONTATOS">
  <h2 style="font-style:italic;">&ensp;&thinsp;</h2>
  <div align="right">( <a href="#readme-top">Voltar ao topo</a> )</div>
  
_MIT licensed | Copyright Â© 2000-2024  [@onixsat](https://onixsat.pt), smartapi@protonmail.com_
</div>
