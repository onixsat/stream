#!/bin/bash

function globais() {

	readonly server_name=$(hostname)
	readonly green='\e[32m'
	readonly blue='\e[34m'
	readonly clear='\e[0m'
	
	ColorGreen(){
		echo -ne $green$1$clear
	}
	ColorBlue(){
		echo -ne $blue$1$clear
	}
	

	if [ ! -d ajuda ] 
	then
		mkdir -p ajuda
	fi
	
	if [[ ! -e /ajuda/ajuda1.html ]]; then
		#truncate -s 0 ajuda/ajuda1.html
		touch /ajuda/ajuda1.html
		cat > ajuda/ajuda1.html <<- "EOF"
<!DOCTYPE HTML>
<html>
  <head>
   <style>
	  html, body{
  position:relative;
  font-family: monaco, monospace;
  color:#c7c7c7;
}
html{
  background:#fff;
}
body{
  background:#000;
  margin:2px 4px;
  padding:.5em 2em;
}
body::before{
  content:'<<<';
  background:#ccc;
  position:absolute;
  top:0;
  left:0;
  color:#000;
}
h1{
  text-align:center;
  margin:1em 0;
}
h1 span{
  background:blue;
  color:#8C7612;
  font-weight:normal;
  font-size:1rem;
  position:relative;
  text-align:center;
}
h1, h2, h3, h4, h5, h6{
  font-weight:normal;
  font-size:1rem;
  margin:1rem 0;
}
h3{
  margin-left:1em;
}
strong{
  color:#FF6E67;
}
em, blockquote{
  color:#6971FF;
  font-style:normal;
}
ul, ol, title{
  color:#CA30C7;
}
ul{
  list-style-type:none;
}
ul li:before{
  content:'* '
}
ul ul {
  padding-left: 4.25em;
}
p{
  margin:1em 2em;
}
a{
  color:#00C300;
  text-decoration:none;
}
a:hover, a:focus{
  color:#8C7612;
}
ol{
  margin-left:1.5em;
}
blockquote{
  margin-left:1em;
}
code, pre{
  font:inherit;
  color: #00A5A7;
}
hr{
  border:none;
  background-image: linear-gradient(to right, #8C7612 95%, rgba(255, 255, 255, 0) 5%);
  background-position: top;
  height:1px;
  background-size: 8px 1px;
  background-repeat: repeat-x;
}
title{
  display:block;
  text-align:right;
}
th{
  color: #C7C500;
}</style>
    <script>addEventListener('load', function(){
  Array.prototype.forEach.call(document.querySelectorAll('h1'), function(h1){
    h1.innerHTML = '<span>' + h1.innerHTML + '</span>'
  })
  var title = document.createElement('title')
  title.innerHTML = document.title
  document.body.insertBefore(title, document.body.firstChild)
})</script>
    <title>LYNX.css - The Text Web-Browser Theme</title>
    <meta charset='utf8'>
  </head>
  <body>
    <hr>
  <h1>OnixSat - Browser</h1>
    <nav>
      <ul>
	<li><a href='https://srv.smartiptv.pt'>Link to actual Lynx</a></li>
	<li><a href='#install'>Installation Instructions</a></li>
	<li><a href='#mail'>Configuraçâo Email</a></li>
	<li><a href='#install'>/etc/hosts</a></li>
	<li><a href='#elements'>Elements</a>
      </ul>
    </nav>
    <p><strong>Lynx.css</strong> is the <em>text</em> web browser theme.</p>
    <p>This is the demo page for the <strong>Lynx.css</strong> software demonstration site.</p>
	  
<style type='text/css'>
pre {
  width: 80%;
  max-height: 490px;
  color: #fff;
  padding: 0px 0px 10px 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  word-wrap: normal;
  overflow: auto;
	  font-family: courier, monospace;
  white-space: pre;
}
	pre span {color: #868686;font-size: 14px}
	pre div {margin-bottom: -15px;font-size: 15px}
</style>
  <h2 id='mail'>Installation Instructions</h2>
    <p>nano /etc/mailips</p>
    <pre>
		<div># Verificar se o ficheiro está correto.</div>
		<span>smartiptv.pt: 94.23.75.50
		mail.smartiptv.pt: 94.23.75.50
		srv.smartiptv.pt: 94.23.75.50
		*: 54.38.191.102</span>
	</pre>
    <p>nano /etc/mailhelo</p>
    <pre>
		<div># Verificar se o ficheiro está correto.</div>
		<span>smartiptv.pt: mail.smartiptv.pt
mail.smartiptv.pt: mail.smartiptv.pt
srv.smartiptv.pt: mail.smartiptv.pt
*: srv.smartiptv.pt</span>
	</pre>
    <p>nano /etc/hosts</p>
    <pre>
		<div># Verificar se o ficheiro está correto.</div>
		<span>
51.75.90.235 51-75-90-235.cprapid.com 51-75-90-235

94.23.75.50 	mail.smartiptv.pt mail
127.0.0.1 		localhost srv
127.0.0.1		localhost srv.smartiptv.pt srv

54.38.191.102           srv.smartiptv.pt srv</span>
	</pre>
	<hr>
    <h2 id='elements'>Mail</h2>
	   <p>Descrição</p>
    <h1>Ver o titulo</h1>
    <hr>
    <h2>https://srv.smartiptv.pt:2087/cpsess4411736012/scripts/srvmng</h2>
    <p style='font-size: 5px;max-width: 5px'>
https://srv.smartiptv.pt:2087/cpsess4411736012/scripts/dosrvmng?tailwatchd=1&tailwatchdmonitor=-1&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3AAPNSPush&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3AChkServd&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3AEximstats&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3AMailHealth&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3AModSecLog&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3ARecentAuthedMailIpTracker&tailwatchd-subopt=Cpanel%3A%3ATailWatch%3A%3AcPBandwd&cpanel_php_fpm=1&cpanel_php_fpmmonitor=1&cpdavd=1&cpdavdmonitor=1&cphulkd=1&cphulkdmonitor=1&crondmonitor=1&dnsadminmonitor=1&exim=1&eximmonitor=1&exim-altportnum=26&httpd=1&httpdmonitor=1&imap=1&imapmonitor=1&ipaliases=1&ipaliasesmonitor=1&lmtpmonitor=1&mailman=1&mailmanmonitor=1&mysql=1&mysqlmonitor=1&named=1&namedmonitor=1&nscd=1&nscdmonitor=1&p0f=1&p0fmonitor=1&pop=1&popmonitor=1&spamd=1&spamdmonitor=1&sshd=1&sshdmonitor=1&rsyslogd=1&rsyslogdmonitor=1</p>
    <p>An <em>emphasized couple</em> of words.</p>
    <p>An <em>emphasized phrase with a <strong>strong</strong> word</em>.</p>
    <p>A <strong>strong phrase with an <em>emphasized</em> word</strong>.</p>
    <hr>
    <h1>Ver o titulo</h1>
    <ol>
      <li><a href='https://jesse.sh/'>https://srv.smartiptv.pt:2087/cpsess4411736012/scripts2/basic_exim_editor#tab_DomainsandIPs</a></li>
    </ol>
    <hr>
    <h2>Code</h2>
    <pre><code>
<div id='tab_DomainsandIPs'>


<table align='' width='10%' class='datatable brick' id='group_DomainsandIPs' border='0' cellpadding='5' cellspacing='0'>
<thead>
<tr><th align='left' colspan='100'>Domains and IPs</th></tr>
</thead>
<tbody>

<!-- |Domains and IPs| |per_domain_mailips| -->
<input type='hidden' name='___original_per_domain_mailips' value='0'><tr id='per_domain_mailips_container' class='tdshade1_noborder'>
<td class='label_and_help' id='labelhelp-per_domain_mailips'><div id='label-per_domain_mailips'>Send mail from the account’s IP address&nbsp;<a href='javascript:void(0)' onclick='showhelp(&quot;per_domain_mailips&quot;); return false;'>[?]</a></div><div><div class='help' id='help-per_domain_mailips' style='display:none;'>Automatically send outgoing mail from the account’s IPv4 address rather than the servers’ default IP address.</div></div></td>
<td class='controls' valign='middle'><div class='brickcontainer'><ul class='tweak_settings binary'><li><label><input type='radio' id='per_domain_mailips_1' name='per_domain_mailips' value='1' onclick='checktweaks();'>&nbsp;On</label></li><li><label><input type='radio' id='per_domain_mailips_0' name='per_domain_mailips' value='0' checked='checked' onclick='checktweaks();'>&nbsp;Off<br><span class='default'>default</span></label></li></ul></div></td></tr>

<!-- |Domains and IPs| |use_rdns_for_helo| -->
<input type='hidden' name='___original_use_rdns_for_helo' value='0'><tr id='use_rdns_for_helo_container' class='tdshade2_noborder'>
<td class='label_and_help' id='labelhelp-use_rdns_for_helo'><div id='label-use_rdns_for_helo'>Use the reverse DNS entry for the mail HELO/EHLO if available&nbsp;<a href='javascript:void(0)' onclick='showhelp(&quot;use_rdns_for_helo&quot;); return false;'>[?]</a></div><div><div class='help' id='help-use_rdns_for_helo' style='display:none;'>The system will use the reverse DNS name for each IP address as the HELO for all outgoing SMTP connections. This only applies during the HELO/EHLO commands.</div></div></td>
<td class='controls' valign='middle'><div class='brickcontainer'><ul class='tweak_settings binary'><li><label><input type='radio' id='use_rdns_for_helo_1' name='use_rdns_for_helo' value='1' onclick='checktweaks();'>&nbsp;On<br><span class='default'>default</span></label></li><li><label><input type='radio' id='use_rdns_for_helo_0' name='use_rdns_for_helo' value='0' checked='checked' onclick='checktweaks();'>&nbsp;Off</label></li></ul></div></td></tr>

<!-- |Domains and IPs| |rebuild_rdns_cache| -->

<!-- |Domains and IPs| |custom_mailhelo| -->
<input type='hidden' name='___original_custom_mailhelo' value='1'><tr id='custom_mailhelo_container' class='tdshade1_noborder'>
<td class='label_and_help' id='labelhelp-custom_mailhelo'><div id='label-custom_mailhelo'>Reference /etc/mailhelo for custom outgoing SMTP HELO&nbsp;<a href='javascript:void(0)' onclick='showhelp(&quot;custom_mailhelo&quot;); return false;'>[?]</a></div><div><div class='help' id='help-custom_mailhelo' style='display:none;'>Send HELO based on the domain name in /etc/mailhelo (<a href='https://go.cpanel.net/eximdiffip' target='_blank'>more information</a>)</div></div></td>
<td class='controls' valign='middle'><div class='brickcontainer'><ul class='tweak_settings binary'><li><label><input type='radio' id='custom_mailhelo_1' name='custom_mailhelo' value='1' checked='checked' onclick='checktweaks();'>&nbsp;On</label></li><li><label><input type='radio' id='custom_mailhelo_0' name='custom_mailhelo' value='0' onclick='checktweaks();'>&nbsp;Off<br><span class='default'>default</span></label></li></ul></div></td></tr>

<!-- |Domains and IPs| |custom_mailips| -->
<input type='hidden' name='___original_custom_mailips' value='1'><tr id='custom_mailips_container' class='tdshade2_noborder'>
<td class='label_and_help' id='labelhelp-custom_mailips'><div id='label-custom_mailips'>Reference /etc/mailips for custom IP on outgoing SMTP connections&nbsp;<a href='javascript:void(0)' onclick='showhelp(&quot;custom_mailips&quot;); return false;'>[?]</a></div><div><div class='help' id='help-custom_mailips' style='display:none;'>Send outgoing mail from the IP address that matches the domain name in /etc/mailips (<a href='https://go.cpanel.net/eximdiffip' target='_blank'>more information</a>)</div></div></td>
<td class='controls' valign='middle'><div class='brickcontainer'><ul class='tweak_settings binary'><li><label><input type='radio' id='custom_mailips_1' name='custom_mailips' value='1' checked='checked' onclick='checktweaks();'>&nbsp;On</label></li><li><label><input type='radio' id='custom_mailips_0' name='custom_mailips' value='0' onclick='checktweaks();'>&nbsp;Off<br><span class='default'>default</span></label></li></ul></div></td></tr>
</tbody>
</table>
</div>
    </code></pre>

    <p>This is a paragraph demonstrating inline code: <code>alert('awesome!')</code></p>
    <hr>
</body>
</html>
		EOF
	fi
	if [[ ! -e /ajuda/ajuda2.html ]]; then
		#truncate -s 0 ajuda/ajuda1.html
		touch /ajuda/ajuda2.html
		cat > ajuda/ajuda2.html <<- "EOF"
		ajuda 2
		EOF
	fi

}
globais

function script(){
	#Script para detecção de sub-dominios e ips de hosts e e html parsing
	if [ "$1" == "" ]
	then
		echo -e "Sem dados"
	else
		echo -e "\033[32;94;5m
	#############################################################################
	- >                                 Ajuda                                 < -
	#############################################################################
		\033[m"
		echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: $1                       
	-----------------------------------------------------------------------------
		\033[m"
		
			#wget -q $1 -O $1.html
			cp ajuda/$1.html $1.html
			grep "href" $1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" |sort -u |sed "s/'/ /" > $1.txt
			sleep 1.00
			
		lynx $1.html
			echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em $1.txt                       
	-----------------------------------------------------------------------------
		\033[m"
			echo -e "\033[31;94;2m
	_____________________________________________________________________________
	 [+] Identificando o ip                                                     
	-----------------------------------------------------------------------------
		\033[m"
	fi

	for hst in $(cat $1.txt);
	do
		host $hst | grep "has address" |sed 's/has address/\tIP:/' | column -t -s ' ';
		# sed 's/has address/<< IP >>/' | column -t;
	done

}

function ajuda1() {
	read -e -p "Ver ajuda:" -i "ajuda1" vip
	script $vip
}
function ajuda2() {
	read -e -p "Ver ajuda:" -i "ajuda2" vip
	script $vip
}


press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "    	1  -  Menu Ajuda 1"
  echo "    	2  -  Menu Ajuda 2"
  echo "    	3  -  Menu Script"
  echo "    	0  -  Exit"
  echo ""
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; ajuda1 ; press_enter ;;
    2 ) clear ; ajuda2 ; press_enter ;;
	3 ) clear ; script2 "54.38.191.102" ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done