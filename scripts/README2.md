<div align="center" id="readme-top">
  <a href="https://onixsat">
    <img src="scripts/logo.png" alt="logo" width="350">
</a>
</div>
<details>
  <summary>Menu de Nevegação</summary>
  <ol>
    <li><a href="#INSTALAR">Instalação</a></li>
    <li><a href="#PASSWORDS">Passwords</a></li>
    <li>
      <a href="#CODIGOS">Códigos</a>
      <ul>
        <li><a href="#BLOQUEAR">Bloquear</a></li>
        <li><a href="#OUTROS">Outros</a></li>
        <li><a href="#CARREGAR">Carregar</a></li>
      </ul>
    </li>
    <li><a href="#CONTATOS">Contatos</a></li>
  </ol>
</details>

<div id="INSTALAR">

<h2 style="font-style:italic;">🛠️ Instalação</h2>
<h6 style="font-style:italic;">Executar os comandos para instalar o sistema.</h6>

```bash
  sudo sudo
  git clone https://github.com/onixsat/almalinux8.git
  cd almalinux8
  bash btk.sh
 ```

</div>

<details id="PASSWORDS">
  <summary>📫 Default Passwords</summary>

<sub>[ [SSH](root) ] Username: $\textcolor{green}{\textsf{root}}\$  Password: $\textcolor{cyan}{\textsf{Palmalinux}}$</sub>

<sup>[ [Encriptação](root) ] $\textcolor{green}{\textsf{Sistema}}\$ Password: $\textcolor{cyan}{\textsf{12345}}$</sup>


<sub>[ [SSH](root) <span style='color:lightblue'>Username: *root*</span> ] Password: $\textcolor{cyan}{\textsf{Palmalinux}}$</sub>\
<sup>[ [Encriptação](root) <span style='color:lightblue'>*Sistema*</span> ] Password: $\textcolor{cyan}{\textsf{12345}}$</sup>

</details>

<details id="CODIGOS">
  <summary><h2 style="font-style:italic;">🚀 Códigos</h2></summary>

_Códigos de script básicos para utilizaão na shell linux._

<div id="BLOQUEAR">

* __Bloquear__\
  *Bloquear alteração de ficheiros*

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
    banner "Apache" "Configuracão" "Password"
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
  <summary><h2 style="font-style:italic;">🛠️ Outros</h2></summary>

_Códigos de script básicos para utilizaão na shell linux._

---
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

🚀🛠️📫
<a href="[link]">[link]</a>

[logo]: scripts/logo.png
[link](https://www.example.com/my%20great%20page "lol")


</details>

<div align="center" id="CONTATOS">
  <div align="right">( <a href="#readme-top">Voltar ao topo</a> )</div>
  <h2 style="font-style:italic;">&ensp;&thinsp; </h2>

_MIT licensed | Copyright © 2011-2024  [@onixsat](https://onixsat.pt), smartapi@protonmail.com_
</div>
