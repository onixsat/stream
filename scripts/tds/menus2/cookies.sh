#!/bin/bash
function banner(){
tput init
	ARG1=${1:-0}
    sleep "$ARG1"
	clear
    echo -n "${GREEN}                                                         "
    echo -e "${BLUE}                       Version ${version}${YELLOW} OnixSat"
    echo -n "${NORMAL}"
}


function globais(){

	readonly version="1.0.0"
	readonly WHITE="$(tput setaf 7)"
	readonly CYAN="$(tput setaf 6)"
	readonly MAGENTA="$(tput setaf 5)"
	readonly YELLOW="$(tput setaf 3)"
	readonly GREEN="$(tput setaf 2)"
	readonly BLUE="$(tput setaf 4)"
	readonly RED="$(tput setaf 1)"
	readonly NORMAL="$(tput sgr0)"
	
	
 PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	 #CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	 CWD="/var/www/html/"
	 HOST=$(hostname -f)
	 PASSV_PORT="50000:50100";
	 PASSV_MIN=$(echo $PASSV_PORT | cut -d':' -f1)
	 PASSV_MAX=$(echo $PASSV_PORT | cut -d':' -f2)
	 ISVPS=$(((dmidecode -t system 2>/dev/null | grep "Manufacturer" | grep -i 'VMware\|KVM\|Bochs\|Virtual\|HVM' > /dev/null) || [ -f /proc/vz/veinfo ]) && echo "SI" || echo "NO")

}
function login(){

	rm -f $CWD/wpwhmcookie.txt
	rm -f $CWD/ver.html
	rm -f $CWD/ver2.html

	CKE="$CWD/wpwhmcookie.txt"
	touch $CKE

	/usr/local/cpanel/etc/init/startcpsrvd
	echo "Configuring the inconfigurable from console..."

	SESS_CREATE=$(whmapi1 create_user_session user=root service=whostmgrd)
	SESS=$(echo "$SESS_CREATE" | grep "cp_security_token:" | cut -d':' -f2- | sed 's/ //')
	SESS_QS=$(echo "$SESS_CREATE" | grep "session:" | cut -d':' -f2- | sed 's/ //' | sed 's/ /%20/g;s/!/%21/g;s/"/%22/g;s/#/%23/g;s/\$/%24/g;s/\&/%26/g;s/'\''/%27/g;s/(/%28/g;s/)/%29/g;s/:/%3A/g')

	readonly lurl="https://$HOST:2087$SESS"
	
	curl -sk "$lurl/login/?session=$SESS_QS" --cookie-jar $CKE > /dev/null
	curl -sk "$lurl/" --cookie $CKE > 1.html

}
function iniciar(){

	ARG0=${0:-0}
	ARG1=${1:-0}
	ARG2=${2:-0}
	
	if [ "$2" ]; then
		link="$lurl/$ARG1"
		curl -sk $link --cookie $CKE --data "'$ARG2'" > /dev/null
	else
		curl -sk "$link" --cookie $CKE > /dev/null
	fi
	echo "${WHITE}Atualizado!"
	banner 2
	
}
globais
login


echo "${BLUE}Disabling compilers...${NORMAL}"
iniciar "scripts2/tweakcompilers" 'action=Disable+Compilers'
banner 2

echo "${BLUE}Disabling SMTP Restrictions (se usa CSF)...${NORMAL}"
iniciar "scripts2/smtpmailgidonly?action=Disable"
banner 2

echo "${BLUE}Disabling Shell Fork Bomb Protection...${NORMAL}"
iniciar "scripts2/modlimits?limits=0"
banner 2

echo "${BLUE}Enabling Background Process Killer...${NORMAL}"
iniciar "json-api/configurebackgroundprocesskiller" 'api.version=1&processes_to_kill=BitchX&processes_to_kill=bnc&processes_to_kill=eggdrop&processes_to_kill=generic-sniffers&processes_to_kill=guardservices&processes_to_kill=ircd&processes_to_kill=psyBNC&processes_to_kill=ptlink&processes_to_kill=services&force=1'
banner 2

echo "${BLUE}Setting Apache...${NORMAL}"
# BASIC CONFIG
iniciar "scripts2/saveglobalapachesetup" 'module=Apache&find=&___original_sslciphersuite=ECDHE-ECDSA-AES256-GCM-SHA384%3AECDHE-RSA-AES256-GCM-SHA384%3AECDHE-ECDSA-CHACHA20-POLY1305%3AECDHE-RSA-CHACHA20-POLY1305%3AECDHE-ECDSA-AES128-GCM-SHA256%3AECDHE-RSA-AES128-GCM-SHA256%3AECDHE-ECDSA-AES256-SHA384%3AECDHE-RSA-AES256-SHA384%3AECDHE-ECDSA-AES128-SHA256%3AECDHE-RSA-AES128-SHA256&sslciphersuite_control=default&___original_sslprotocol=TLSv1.2&sslprotocol_control=default&___original_loglevel=warn&loglevel=warn&___original_traceenable=Off&traceenable=Off&___original_serversignature=Off&serversignature=Off&___original_servertokens=ProductOnly&servertokens=ProductOnly&___original_fileetag=None&fileetag=None&___original_root_options=&root_options=FollowSymLinks&root_options=IncludesNOEXEC&root_options=SymLinksIfOwnerMatch&___original_startservers=5&startservers_control=default&___original_minspareservers=5&minspareservers_control=default&___original_maxspareservers=10&maxspareservers_control=default&___original_optimize_htaccess=search_homedir_below&optimize_htaccess=search_homedir_below&___original_serverlimit=256&serverlimit_control=default&___original_maxclients=150&maxclients_control=other&maxclients_other=100&___original_maxrequestsperchild=10000&maxrequestsperchild_control=default&___original_keepalive=On&keepalive=1&___original_keepalivetimeout=5&keepalivetimeout_control=3&___original_maxkeepaliverequests=100&maxkeepaliverequests_control=20&___original_timeout=300&timeout_control=default&___original_symlink_protect=Off&symlink_protect=0&its_for_real=1'
banner 2

# DIRECTORYINDEX
iniciar "scripts2/save_apache_directoryindex" 'valid_submit=1&dirindex=index.php&dirindex=index.php5&dirindex=index.php4&dirindex=index.php3&dirindex=index.perl&dirindex=index.pl&dirindex=index.plx&dirindex=index.ppl&dirindex=index.cgi&dirindex=index.jsp&dirindex=index.jp&dirindex=index.phtml&dirindex=index.shtml&dirindex=index.xhtml&dirindex=index.html&dirindex=index.htm&dirindex=index.wml&dirindex=Default.html&dirindex=Default.htm&dirindex=default.html&dirindex=default.htm&dirindex=home.html&dirindex=home.htm&dirindex=index.js'

iniciar "scripts2/save_apache_mem_limits" 'newRLimitMem=enabled&newRLimitMemValue=1027&restart_apache=on&btnSave=1'

/scripts/rebuildhttpdconf
service httpd restart
echo "ok"
# DOVECOT
#iniciar "scripts/savedovecotsetup" 'protocols_enabled_imap=on&protocols_enabled_pop3=on&enable_plaintext_auth=yes&ssl_cipher_list=ECDHE-ECDSA-AES128-GCM-SHA256%3AECDHE-RSA-AES128-GCM-SHA256%3AECDHE-ECDSA-AES256-GCM-SHA384%3AECDHE-RSA-AES256-GCM-SHA384%3AECDHE-ECDSA-CHACHA20-POLY1305%3AECDHE-RSA-CHACHA20-POLY1305%3ADHE-RSA-AES128-GCM-SHA256%3ADHE-RSA-AES256-GCM-SHA384&ssl_min_protocol=TLSv1.2&max_mail_processes=512&mail_process_size=512&protocol_imap.mail_max_userip_connections=20&protocol_imap.imap_idle_notify_interval=24&protocol_pop3.mail_max_userip_connections=3&login_processes_count=2&login_max_processes_count=50&login_process_size=128&imap_hibernate_timeout=30&auth_cache_size=1M&auth_cache_ttl=3600&auth_cache_negative_ttl=3600&login_process_per_connection=no&config_vsz_limit=2048&mailbox_idle_check_interval=30&mdbox_rotate_size=10M&mdbox_rotate_interval=0&incoming_reached_quota=bounce&lmtp_process_min_avail=0&lmtp_process_limit=500&lmtp_user_concurrency_limit=4'

# EXIM
iniciar "scripts2/saveeximtweaks" 'in_tab=1&module=Mail&find=&___original_acl_deny_spam_score_over_int=&___undef_original_acl_deny_spam_score_over_int=1&acl_deny_spam_score_over_int_control=undef&___original_acl_dictionary_attack=1&acl_dictionary_attack=1&___original_acl_primary_hostname_bl=0&acl_primary_hostname_bl=0&___original_acl_spam_scan_secondarymx=1&acl_spam_scan_secondarymx=1&___original_acl_ratelimit=1&acl_ratelimit=1&___original_acl_ratelimit_spam_score_over_int=&___undef_original_acl_ratelimit_spam_score_over_int=1&acl_ratelimit_spam_score_over_int_control=undef&___original_acl_slow_fail_block=1&acl_slow_fail_block=1&___original_acl_requirehelo=0&acl_requirehelo=1&___original_acl_delay_unknown_hosts=1&acl_delay_unknown_hosts=1&___original_acl_dont_delay_greylisting_trusted_hosts=1&acl_dont_delay_greylisting_trusted_hosts=1&___original_acl_dont_delay_greylisting_common_mail_providers=0&acl_dont_delay_greylisting_common_mail_providers=0&___original_acl_requirehelonoforge=1&acl_requirehelonoforge=1&___original_acl_requirehelonold=0&acl_requirehelonold=0&___original_acl_requirehelosyntax=1&acl_requirehelosyntax=1&___original_acl_dkim_disable=1&acl_dkim_disable=1&___original_acl_dkim_bl=0&___original_acl_deny_rcpt_soft_limit=&___undef_original_acl_deny_rcpt_soft_limit=1&acl_deny_rcpt_soft_limit_control=undef&___original_acl_deny_rcpt_hard_limit=&___undef_original_acl_deny_rcpt_hard_limit=1&acl_deny_rcpt_hard_limit_control=undef&___original_spammer_list_ips_button=&___undef_original_spammer_list_ips_button=1&___original_sender_verify_bypass_ips_button=&___undef_original_sender_verify_bypass_ips_button=1&___original_trusted_mail_hosts_ips_button=&___undef_original_trusted_mail_hosts_ips_button=1&___original_skip_smtp_check_ips_button=&___undef_original_skip_smtp_check_ips_button=1&___original_backup_mail_hosts_button=&___undef_original_backup_mail_hosts_button=1&___original_trusted_mail_users_button=&___undef_original_trusted_mail_users_button=1&___original_blocked_domains_button=&___undef_original_blocked_domains_button=1&___original_filter_emails_by_country_button=&___undef_original_filter_emails_by_country_button=1&___original_per_domain_mailips=1&per_domain_mailips=0&___original_custom_mailhelo=1&___original_custom_mailips=1&___original_systemfilter=%2Fetc%2Fcpanel_exim_system_filter&systemfilter_control=default&___original_filter_attachments=1&filter_attachments=1&___original_filter_spam_rewrite=1&filter_spam_rewrite=1&___original_filter_fail_spam_score_over_int=&___undef_original_filter_fail_spam_score_over_int=1&filter_fail_spam_score_over_int_control=undef&___original_spam_header=***SPAM***&spam_header_control=default&___original_acl_0tracksenders=0&acl_0tracksenders=0&___original_callouts=0&callouts=0&___original_smarthost_routelist=&smarthost_routelist_control=default&___original_smarthost_autodiscover_spf_include=1&smarthost_autodiscover_spf_include=1&___original_spf_include_hosts=&spf_include_hosts_control=default&___original_rewrite_from=disable&rewrite_from=disable&___original_hiderecpfailuremessage=0&hiderecpfailuremessage=0&___original_malware_deferok=1&malware_deferok=1&___original_senderverify=1&senderverify=1&___original_setsenderheader=0&setsenderheader=0&___original_spam_deferok=1&spam_deferok=1&___original_srs=0&srs=0&___original_query_apache_for_nobody_senders=1&query_apache_for_nobody_senders=1&___original_trust_x_php_script=1&trust_x_php_script=1&___original_dsn_advertise_hosts=&___undef_original_dsn_advertise_hosts=1&dsn_advertise_hosts_control=undef&___original_smtputf8_advertise_hosts=&___undef_original_smtputf8_advertise_hosts=1&smtputf8_advertise_hosts_control=undef&___original_manage_rbls_button=&___undef_original_manage_rbls_button=1&___original_acl_spamcop_rbl=1&acl_spamcop_rbl=1&___original_acl_spamhaus_rbl=1&acl_spamhaus_rbl=1&___original_rbl_whitelist_neighbor_netblocks=1&rbl_whitelist_neighbor_netblocks=1&___original_rbl_whitelist_greylist_common_mail_providers=1&rbl_whitelist_greylist_common_mail_providers=1&___original_rbl_whitelist_greylist_trusted_netblocks=0&rbl_whitelist_greylist_trusted_netblocks=0&___original_rbl_whitelist=&rbl_whitelist=&___original_allowweakciphers=1&allowweakciphers=1&___original_require_secure_auth=0&require_secure_auth=0&___original_openssl_options=+%2Bno_sslv2+%2Bno_sslv3&openssl_options_control=other&openssl_options_other=+%2Bno_sslv2+%2Bno_sslv3&___original_tls_require_ciphers=ECDHE-ECDSA-CHACHA20-POLY1305%3AECDHE-RSA-CHACHA20-POLY1305%3AECDHE-ECDSA-AES128-GCM-SHA256%3AECDHE-RSA-AES128-GCM-SHA256%3AECDHE-ECDSA-AES256-GCM-SHA384%3AECDHE-RSA-AES256-GCM-SHA384%3ADHE-RSA-AES128-GCM-SHA256%3ADHE-RSA-AES256-GCM-SHA384%3AECDHE-ECDSA-AES128-SHA256%3AECDHE-RSA-AES128-SHA256%3AECDHE-ECDSA-AES128-SHA%3AECDHE-RSA-AES256-SHA384%3AECDHE-RSA-AES128-SHA%3AECDHE-ECDSA-AES256-SHA384%3AECDHE-ECDSA-AES256-SHA%3AECDHE-RSA-AES256-SHA%3ADHE-RSA-AES128-SHA256%3ADHE-RSA-AES128-SHA%3ADHE-RSA-AES256-SHA256%3ADHE-RSA-AES256-SHA%3AECDHE-ECDSA-DES-CBC3-SHA%3AECDHE-RSA-DES-CBC3-SHA%3AEDH-RSA-DES-CBC3-SHA%3AAES128-GCM-SHA256%3AAES256-GCM-SHA384%3AAES128-SHA256%3AAES256-SHA256%3AAES128-SHA%3AAES256-SHA%3ADES-CBC3-SHA%3A%21DSS&tls_require_ciphers_control=other&tls_require_ciphers_other=ECDHE-ECDSA-CHACHA20-POLY1305%3AECDHE-RSA-CHACHA20-POLY1305%3AECDHE-ECDSA-AES128-GCM-SHA256%3AECDHE-RSA-AES128-GCM-SHA256%3AECDHE-ECDSA-AES256-GCM-SHA384%3AECDHE-RSA-AES256-GCM-SHA384%3ADHE-RSA-AES128-GCM-SHA256%3ADHE-RSA-AES256-GCM-SHA384%3AECDHE-ECDSA-AES128-SHA256%3AECDHE-RSA-AES128-SHA256%3AECDHE-ECDSA-AES128-SHA%3AECDHE-RSA-AES256-SHA384%3AECDHE-RSA-AES128-SHA%3AECDHE-ECDSA-AES256-SHA384%3AECDHE-ECDSA-AES256-SHA%3AECDHE-RSA-AES256-SHA%3ADHE-RSA-AES128-SHA256%3ADHE-RSA-AES128-SHA%3ADHE-RSA-AES256-SHA256%3ADHE-RSA-AES256-SHA%3AECDHE-ECDSA-DES-CBC3-SHA%3AECDHE-RSA-DES-CBC3-SHA%3AEDH-RSA-DES-CBC3-SHA%3AAES128-GCM-SHA256%3AAES256-GCM-SHA384%3AAES128-SHA256%3AAES256-SHA256%3AAES128-SHA%3AAES256-SHA%3ADES-CBC3-SHA%3A%21DSS&___original_globalspamassassin=0&globalspamassassin=0&___original_max_spam_scan_size=1000&max_spam_scan_size_control=default&___original_acl_outgoing_spam_scan=0&acl_outgoing_spam_scan=0&___original_acl_outgoing_spam_scan_over_int=&___undef_original_acl_outgoing_spam_scan_over_int=1&acl_outgoing_spam_scan_over_int_control=undef&___original_no_forward_outbound_spam=0&no_forward_outbound_spam=0&___original_no_forward_outbound_spam_over_int=&___undef_original_no_forward_outbound_spam_over_int=1&no_forward_outbound_spam_over_int_control=undef&___original_spamassassin_plugin_BAYES_POISON_DEFENSE=1&spamassassin_plugin_BAYES_POISON_DEFENSE=1&___original_spamassassin_plugin_P0f=1&spamassassin_plugin_P0f=1&___original_spamassassin_plugin_KAM=1&spamassassin_plugin_KAM=1&___original_spamassassin_plugin_CPANEL=1&spamassassin_plugin_CPANEL=1'


# ACTIVATE BIND INSTEAD OF POWERDNS
curl -sk "https://$HOST:2087/$SESS/scripts/doconfigurenameserver" --cookie $CKE -X GET --data 'nameserver=bind' > /dev/null
iniciar "scripts2/savedovecotsetup" 'protocols_enabled_imap=on&protocols_enabled_pop3=on&enable_plaintext_auth=yes&ssl_cipher_list=ECDHE-ECDSA-AES128-GCM-SHA256%3AECDHE-RSA-AES128-GCM-SHA256%3AECDHE-ECDSA-AES256-GCM-SHA384%3AECDHE-RSA-AES256-GCM-SHA384%3AECDHE-ECDSA-CHACHA20-POLY1305%3AECDHE-RSA-CHACHA20-POLY1305%3ADHE-RSA-AES128-GCM-SHA256%3ADHE-RSA-AES256-GCM-SHA384&ssl_min_protocol=TLSv1.2&max_mail_processes=512&mail_process_size=512&protocol_imap.mail_max_userip_connections=20&protocol_imap.imap_idle_notify_interval=24&protocol_pop3.mail_max_userip_connections=3&login_processes_count=2&login_max_processes_count=50&login_process_size=128&imap_hibernate_timeout=30&auth_cache_size=1M&auth_cache_ttl=3600&auth_cache_negative_ttl=3600&login_process_per_connection=no&config_vsz_limit=2048&mailbox_idle_check_interval=30&mdbox_rotate_size=10M&mdbox_rotate_interval=0&incoming_reached_quota=bounce&lmtp_process_min_avail=0&lmtp_process_limit=500&lmtp_user_concurrency_limit=4'

# REMOVE COOKIE
rm -f $CWD/wpwhmcookie.txt


<script type="text/javascript">
//<![CDATA[
var validators = {};

// set default values
var set_defaults = function() {
    var protocols = [{"name":"IMAP","checked":"checked","option":"imap"},{"name":"LMTP","checked":"checked","option":"lmtp"},{"checked":"checked","name":"POP3","option":"pop3"}];

    var default_protocols = {"imap":1,"pop3":1};
    for (var p=protocols.length-1; p>=0; p--) {
        var cur_prot = protocols[p].option;
        DOM.get("protocols_enabled_" + cur_prot).checked = cur_prot in default_protocols;
    }
















    YAHOO.util.Dom.get("enable_plaintext_auth").value = 'yes';
    YAHOO.util.Dom.get("ssl_cipher_list").value = 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384';
    YAHOO.util.Dom.get("protocol_imap.mail_max_userip_connections").value = '20';
    YAHOO.util.Dom.get("protocol_imap.imap_idle_notify_interval").value = '24';
    YAHOO.util.Dom.get("protocol_pop3.mail_max_userip_connections").value = '3';
    YAHOO.util.Dom.get("login_processes_count").value = '2';
    YAHOO.util.Dom.get("login_max_processes_count").value = '50';
    YAHOO.util.Dom.get("login_process_size").value = '128';
    YAHOO.util.Dom.get("mail_process_size").value = '512';
    YAHOO.util.Dom.get("mdbox_rotate_interval").value = '0';
    YAHOO.util.Dom.get("mdbox_rotate_size").value = '10M';
    YAHOO.util.Dom.get("max_mail_processes").value = '512';
    YAHOO.util.Dom.get("auth_cache_size").value = '1M';
    YAHOO.util.Dom.get("auth_cache_ttl").value = '3600';
    YAHOO.util.Dom.get("auth_cache_negative_ttl").value = '3600';
    YAHOO.util.Dom.get("login_process_per_connection").value = 'no';
    YAHOO.util.Dom.get("mailbox_idle_check_interval").value = '30';
    YAHOO.util.Dom.get("imap_hibernate_timeout").value = '30';
    YAHOO.util.Dom.get("expire_trash_ttl").value = '30';
    YAHOO.util.Dom.get("expire_spam_ttl").value = '30';
    YAHOO.util.Dom.get("lmtp_user_concurrency_limit").value = '4';
    YAHOO.util.Dom.get("lmtp_process_min_avail").value = '0';
    YAHOO.util.Dom.get("compress_messages_level").value = '6';

    YAHOO.util.Dom.get("lmtp_process_limit").value = '500';
    YAHOO.util.Dom.get("config_vsz_limit").value = '2048';
    YAHOO.util.Dom.get("ssl_min_protocol").value = 'TLSv1.2';
    YAHOO.util.Dom.get("include_trash_in_quota").checked = false;
    YAHOO.util.Dom.get("compress_messages").checked = false;
    var quota_radios = document.getElementsByName("incoming_reached_quota");
    for (var qr=0; qr<quota_radios.length; qr++) {
        quota_radios[qr].checked = (quota_radios[qr].value === "bounce");
    }

    verify_data();
};

var reset_form = function() {
    // reset the form
    YAHOO.util.Dom.get("mainform").reset();

    // show validation
    verify_data();
};

var verify_data = function() {
    for (var i in validators) {
        validators[i].verify();
    }
};

var ssl_chars = function(value) {
    var pattern = new RegExp(/^[\-\w\!\+\@\~\:]+$/);
    if (pattern.test(value) == false) return false;
    return true;
};

//CJT’s functions for this don’t work! The value “-” gets accepted.
function is_integer(input) {
    var val = input.value;
    return /^-?[0-9]+(?:\.0+)?$/.test(val);
}
function is_positive_integer(input) {
    var val = input.value;
    return( is_integer(input) && parseInt(val, 10) > 0 );
}
function is_nonnegative_integer(input) {
    var val = input.value;
    return( is_integer(input) && parseInt(val, 10) >= 0 );
}

function is_invalid_weeks_rotation_interval() {
    var val = YAHOO.util.Dom.get("mdbox_rotate_interval").value;
    if (val.match('w$') && parseInt(val) > 7101) return false;
    return true;
}

function is_invalid_days_rotation_interval() {
    var val = YAHOO.util.Dom.get("mdbox_rotate_interval").value;
    if (val.match('d$') && parseInt(val) > 49710) return false;
    return true;
}

var init_page = function() {

    // ssl cipher list
    validators['ssl_cipher_list'] = new CPANEL.validate.validator("\u003cabbr title=\"Secure Socket Layer\" class=\"initialism\">SSL\u003c\/abbr> Cipher List");
    validators['ssl_cipher_list'].add("ssl_cipher_list", function() { return ssl_chars(YAHOO.util.Dom.get("ssl_cipher_list").value); }, "The \u003cabbr title=\"Secure Socket Layer\" class=\"initialism\">SSL\u003c\/abbr> Cipher List must be defined using alphanumeric characters with regular expressions ! + _ @ ~ and use a colon (:) for a separator.");

    // maximum imap connections per IP
    validators['protocol_imap.mail_max_userip_connections'] = new CPANEL.validate.validator("Maximum \u003cabbr title=\"Internet Message Access Protocol\" class=\"initialism\">IMAP\u003c\/abbr> Connections Per \u003cabbr title=\"Internet Protocol\" class=\"initialism\">IP\u003c\/abbr> Address");
    validators['protocol_imap.mail_max_userip_connections'].add("protocol_imap.mail_max_userip_connections", "positive_integer", "The input value for Maximum \u003cabbr title=\"Internet Message Access Protocol\" class=\"initialism\">IMAP\u003c\/abbr> Connections Per \u003cabbr title=\"Internet Protocol\" class=\"initialism\">IP\u003c\/abbr> Address must be a positive whole number.");
    validators['protocol_imap.mail_max_userip_connections'].add("protocol_imap.mail_max_userip_connections", "max_length(%input%, 4)", "The input value for Maximum \u003cabbr title=\"Internet Message Access Protocol\" class=\"initialism\">IMAP\u003c\/abbr> Connections Per \u003cabbr title=\"Internet Protocol\" class=\"initialism\">IP\u003c\/abbr> Address cannot exceed 4 digits.");

    // Interval between IMAP IDLE "OK Still here" messages
    validators['protocol_imap.imap_idle_notify_interval'] = new CPANEL.validate.validator("Interval between \u003cabbr title=\"Internet Message Access Protocol\" class=\"initialism\">IMAP\u003c\/abbr> IDLE “OK Still here” messages.");
    validators['protocol_imap.imap_idle_notify_interval'].add("protocol_imap.imap_idle_notify_interval", "positive_integer", "The input value for “Interval between \u003cabbr title=\"Internet Message Access Protocol\" class=\"initialism\">IMAP\u003c\/abbr> IDLE ‘OK Still here’ messages” must be a positive whole number.");
    validators['protocol_imap.imap_idle_notify_interval'].add("protocol_imap.imap_idle_notify_interval", "max_length(%input%, 2)", "Interval between \u003cabbr title=\"Internet Message Access Protocol\" class=\"initialism\">IMAP\u003c\/abbr> IDLE “OK Still here” messages cannot exceed 2 digits.");


    // maximum pop3 connections per IP
    validators['protocol_pop3.mail_max_userip_connections'] = new CPANEL.validate.validator("Maximum \u003cabbr title=\"Post Office Protocol\" class=\"initialism\">POP3\u003c\/abbr> Connections per \u003cabbr title=\"Internet Protocol\" class=\"initialism\">IP\u003c\/abbr> Address");
    validators['protocol_pop3.mail_max_userip_connections'].add("protocol_pop3.mail_max_userip_connections", "positive_integer", "The input value for Maximum \u003cabbr title=\"Post Office Protocol\" class=\"initialism\">POP3\u003c\/abbr> Connections Per \u003cabbr title=\"Internet Protocol\" class=\"initialism\">IP\u003c\/abbr> must be a positive whole number.");
    validators['protocol_pop3.mail_max_userip_connections'].add("protocol_pop3.mail_max_userip_connections", "max_length(%input%, 4)", "The input value for Maximum \u003cabbr title=\"Post Office Protocol\" class=\"initialism\">POP3\u003c\/abbr> Connections Per \u003cabbr title=\"Internet Protocol\" class=\"initialism\">IP\u003c\/abbr> Address cannot exceed 4 digits.");

    // spare authentication processes
    validators['login_processes_count'] = new CPANEL.validate.validator("Number of Spare Authentication Processes");
    validators['login_processes_count'].add("login_processes_count", "positive_integer", "The input value for Number of Spare Authentication Processes must be a positive whole number.");
    validators['login_processes_count'].add("login_processes_count", "max_length(%input%, 4)", "The input value for Number of Spare Authentication Processes cannot exceed 4 digits.");
    validators['login_processes_count'].add("login_processes_count",
        function(el) {
            var lpc = 1 * el.value;
            var lmpc = 1 * DOM.get("login_max_processes_count").value;
console.log(lpc, lmpc, arguments);
            return( lpc <= lmpc );
        },
        "This value cannot exceed the value of “Maximum Number of Authentication Processes”."
    );

    // maximum authentication processes
    validators['login_max_processes_count'] = new CPANEL.validate.validator("Maximum Number of Authentication Processes");
    validators['login_max_processes_count'].add("login_max_processes_count", "positive_integer", "The input value for Maximum Number of Authentication Processes must be a positive whole number.");
    validators['login_max_processes_count'].add("login_max_processes_count", "max_length(%input%, 4)", "The input value for Maximum Number of Authentication Processes cannot exceed 4 digits.");

    // maximum mail processes
    validators['max_mail_processes'] = new CPANEL.validate.validator("Maximum Number of Mail Processes");
    validators['max_mail_processes'].add("max_mail_processes", "positive_integer", "The input value for Maximum Number of Mail Processes must be a positive whole number.");
    validators['max_mail_processes'].add("max_mail_processes", "max_length(%input%, 4)", "The input value for Maximum Number of Mail Processes cannot exceed 4 digits.");

    // maximum mail process size
    validators['mail_process_size'] = new CPANEL.validate.validator("Process Memory Limit for Mail (\u003cabbr title=\"Megabytes\">MB\u003c\/abbr>)");
    validators['mail_process_size'].add("mail_process_size", "positive_integer", "The input value for Process Limit for Mail must be a positive whole number.");
    validators['mail_process_size'].add("mail_process_size", "max_length(%input%, 4)", "The input value for Process Limit for Mail cannot exceed 4 digits.");

    validators['mdbox_rotate_size'] = new CPANEL.validate.validator("MDBOX rotation size (\u003cabbr title=\"Megabytes\" class=\"initialism\">MB\u003c\/abbr>)");
    validators['mdbox_rotate_size'].add("mdbox_rotate_size", "max_length(%input%, 4)", "The input value for MDBOX rotation size cannot exceed 4 characters.");
    validators['mdbox_rotate_size'].add("mdbox_rotate_size",
                    function() { return YAHOO.util.Dom.get("mdbox_rotate_size").value.match('^[0-9]{1,3}M$'); },
                    "The MDBOX rotation size (\u003cabbr title=\"Megabytes\" class=\"initialism\">MB\u003c\/abbr>) must be a positive integer followed by the character “M”. (Example: 2M, 10M)");

    // maximum login process size
    validators['login_process_size'] = new CPANEL.validate.validator("Process Memory Limit for Authentication (\u003cabbr title=\"Megabytes\">MB\u003c\/abbr>)");
    validators['login_process_size'].add("login_process_size", "positive_integer", "The input value for Process Memory Limit for Authentication must be a positive whole number.");
    validators['login_process_size'].add("login_process_size", "max_length(%input%, 4)", "The input value for Process Memory Limit for Authentication cannot exceed 4 digits.");

    validators['config_vsz_limit'] = new CPANEL.validate.validator("Process Memory Limit: config (\u003cabbr title=\"Megabytes\">MB\u003c\/abbr>)");
    validators['config_vsz_limit'].add("config_vsz_limit", is_positive_integer, "This value must be a positive integer.");
    validators['config_vsz_limit'].add("config_vsz_limit", "min_value(%input%, 128)", "This value cannot be lower than 128.");
    validators['config_vsz_limit'].add("config_vsz_limit", "max_value(%input%, 99999)", "This value cannot be greater than 99,999.");

    validators['mdbox_rotate_interval'] = new CPANEL.validate.validator("MDBOX rotation interval (Weeks or Days)");
    validators['mdbox_rotate_interval'].add("mdbox_rotate_interval", "max_length(%input%, 6)", "The input value for MDBOX rotation interval cannot exceed 6 characters.");
    validators['mdbox_rotate_interval'].add("mdbox_rotate_interval",
                    function() { return YAHOO.util.Dom.get("mdbox_rotate_interval").value.match('^(0|[1-9][0-9]{0,4}[wd])$'); },
                    "The MDBOX rotation interval (Weeks or Days) must be a positive integer followed by the character “w” or “d” or “0”. (Example: 500d, 0)"
    );
    validators['mdbox_rotate_interval'].add("mdbox_rotate_interval", is_invalid_weeks_rotation_interval, "The MDBOX rotation interval cannot be more than 7101 weeks.");
    validators['mdbox_rotate_interval'].add("mdbox_rotate_interval", is_invalid_days_rotation_interval, "The MDBOX rotation interval cannot be more than 49710 days.");


    // size of authentication cache
    validators['auth_cache_size'] = new CPANEL.validate.validator("Size of Authentication Cache (\u003cabbr title=\"Megabytes\">MB\u003c\/abbr>)");
    validators['auth_cache_size'].add("auth_cache_size", "max_length(%input%, 4)", "The input value for Size of Authentication Cache cannot exceed 4 characters.");
    validators['auth_cache_size'].add("auth_cache_size",
                    function() { return YAHOO.util.Dom.get("auth_cache_size").value.match('^[0-9]{1,3}M$'); },
                    "The Size of Authentication Cache (\u003cabbr title=\"Megabytes\" class=\"initialism\">MB\u003c\/abbr>) must be a positive integer followed by the character “M”. (Example: 2M, 10M)");


    // time to cache successful logins
    validators['auth_cache_ttl'] = new CPANEL.validate.validator("Time to Cache Successful Logins");
    validators['auth_cache_ttl'].add("auth_cache_ttl", "positive_integer", "The input value for Time to Cache Successful Logins must be a positive whole number.");
    validators['auth_cache_ttl'].add("auth_cache_ttl", "max_length(%input%, 4)", "The input value for Time to Cache Successful Logins cannot exceed 4 digits.");

    // time to cache failed logins
    validators['auth_cache_negative_ttl'] = new CPANEL.validate.validator("Time to Cache Failed Logins");
    validators['auth_cache_negative_ttl'].add("auth_cache_negative_ttl", "positive_integer", "The input value for Time to Cache Failed Logins must be a positive whole number.");
    validators['auth_cache_negative_ttl'].add("auth_cache_negative_ttl", "max_length(%input%, 4)", "The input value for Time to Cache Failed Logins cannot exceed 4 digits.");

    // idle check interval
    validators['mailbox_idle_check_interval'] = new CPANEL.validate.validator("Idle Check Interval");
    validators['mailbox_idle_check_interval'].add("mailbox_idle_check_interval", "min_value(%input%, 1)", "The input value for Idle Check Interval must be an integer greater than 0.");
    validators['mailbox_idle_check_interval'].add("mailbox_idle_check_interval","max_length(%input%, 4)", "The input value for Idle Check Interval cannot exceed 4 digits.");

    // imap hibernate timeout
    validators['imap_hibernate_timeout'] = new CPANEL.validate.validator("Idle Hibernate Timeout (Seconds)");
    validators['imap_hibernate_timeout'].add("imap_hibernate_timeout", "min_value(%input%, 0)", "The input value for Idle Hibernate Timeout (Seconds) must be a valid positive integer.");
    validators['imap_hibernate_timeout'].add("imap_hibernate_timeout","max_length(%input%, 4)", "The input value for Idle Hibernate Timeout (Seconds) cannot exceed 4 digits.");

    // expire trash ttl
    validators['expire_trash_ttl'] = new CPANEL.validate.validator("Trash Expire Time");
    validators['expire_trash_ttl'].add("expire_trash_ttl", "min_value(%input%, 1)", "The input value for Trash Expire Time must be an integer greater than 0.");
    validators['expire_trash_ttl'].add("expire_trash_ttl", "max_value(%input%, 366)", "The input value for Trash Expire Time must be an integer less than 366.");

    // expire spam ttl
    validators['expire_spam_ttl'] = new CPANEL.validate.validator("Spam Expire Time");
    validators['expire_spam_ttl'].add("expire_spam_ttl", "min_value(%input%, 1)", "The input value for Spam Expire Time must be an integer greater than 0.");
    validators['expire_spam_ttl'].add("expire_spam_ttl", "max_value(%input%, 366)", "The input value for Spam Expire Time must be an integer less than 366.");

    validators['lmtp_process_min_avail'] = new CPANEL.validate.validator("Minimum Available LMTP Processes");
    validators['lmtp_process_min_avail'].add("lmtp_process_min_avail", is_integer, "“Minimum Available LMTP Processes” must be an integer.");
    validators['lmtp_process_min_avail'].add("lmtp_process_min_avail", "min_value(%input%, 0)", "“Minimum Available LMTP Processes” cannot be a negative value.");
    validators['lmtp_process_min_avail'].add("lmtp_process_min_avail", "max_value(%input%, 99)", "“Minimum Available LMTP Processes” cannot be greater than 99.");

    validators['compress_messages_level'] = new CPANEL.validate.validator("Compression Level");
    validators['compress_messages_level'].add("compress_messages_level", is_integer, "“Compression Level” must be an integer.");
    validators['compress_messages_level'].add("compress_messages_level", "min_value(%input%, 1)", "“Compression Level” cannot be less than 1.");
    validators['compress_messages_level'].add("compress_messages_level", "max_value(%input%, 9)", "“Compression Level” cannot be greater than 9.");


    validators['lmtp_process_limit'] = new CPANEL.validate.validator("LMTP Process Limit");
    validators['lmtp_process_limit'].add("lmtp_process_limit", is_positive_integer, "“LMTP Process Limit” must be a positive integer.");
    validators['lmtp_process_limit'].add("lmtp_process_limit", "max_value(%input%, 9999)", "“LMTP Process Limit” cannot be greater than 9,999.");

    validators["lmtp_user_concurrency_limit"] = new CPANEL.validate.validator("LMTP User Concurrency Limit");
    validators["lmtp_user_concurrency_limit"].add("lmtp_user_concurrency_limit", is_nonnegative_integer, "“LMTP User Concurrency Limit” must be a nonnegative integer.");
    validators["lmtp_user_concurrency_limit"].add(
        "lmtp_user_concurrency_limit",
        function(el) {
            var ucl = 1 * el.value;
            var pl = 1 * DOM.get("lmtp_process_limit").value;
console.log(ucl, pl, arguments);
            return( ucl <= pl );
        },
        "This value cannot exceed the value of “LMTP Process Limit”."
    );

    for (var i in validators) {
        validators[i].attach();
    }

    CPANEL.validate.attach_to_form("submit_page", validators);

    YAHOO.util.Event.on("use_defaults", "click", set_defaults);
    YAHOO.util.Event.on("reset_form", "click", reset_form);

    //CPANEL.panels.create_help("example_ssl_cipher_link", "example_ssl_cipher");

    YAHOO.util.Event.on("expire_trash", "click", function(){
        YAHOO.util.Dom.get("expire_trash_ttl").disabled = !YAHOO.util.Dom.get("expire_trash").checked;
    });

    YAHOO.util.Event.on("expire_spam", "click", function(){
        YAHOO.util.Dom.get("expire_spam_ttl").disabled = !YAHOO.util.Dom.get("expire_spam").checked;
    });

    YAHOO.util.Event.on("compress_messages", "click", function(){
        YAHOO.util.Dom.get("compress_messages_level").disabled = !YAHOO.util.Dom.get("compress_messages").checked;
    });
};
YAHOO.util.Event.onDOMReady(init_page);
//]]>
</script>



<form action="/cpsess6671913592/scripts2/savedovecotsetup" name="mainform" id="mainform" method="post">
<table id="dovecotsetup" border="0" cellspacing="0" cellpadding="0">
    <tbody><tr>
        <td>
            <label class="label_title">Protocols Enabled</label>
            
                <input type="checkbox" name="protocols_enabled_imap" class="ipv4_protocol_controls" id="protocols_enabled_imap" onchange="disableProtocol()" checked="checked">
                <label for="protocols_enabled_imap"><abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr></label>
            
                <input disabled="disabled" type="checkbox" name="protocols_enabled_lmtp" class="ipv4_protocol_controls" id="protocols_enabled_lmtp" onchange="disableProtocol()" checked="checked">
                <label for="protocols_enabled_lmtp"><abbr title="Local Mail Transfer Protocol" class="initialism">LMTP</abbr></label>
            
                <input type="checkbox" name="protocols_enabled_pop3" class="ipv4_protocol_controls" id="protocols_enabled_pop3" onchange="disableProtocol()" checked="checked">
                <label for="protocols_enabled_pop3"><abbr title="Post Office Protocol 3" class="initialism">POP3</abbr></label>
            
            <p>These checkboxes select which protocols Dovecot will listen on.</p>
            <p><strong>Note</strong>: cPanel’s Webmail system requires <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> in order to function.</p>
            <p><strong>Note</strong>: If you do not select a checkbox, the system will operate in authentication-only mode.</p>
            <p><strong>Note</strong>: <abbr title="Local Mail Transfer Protocol" class="initialism">LMTP</abbr> is required and you cannot disable it.</p>
        </td>
    </tr>

    <tr>
        <td>
            <label class="label_title">IPv6 Enabled</label>
                <input type="checkbox" name="ipv6" id="ipv6">
            <p>This option allows you to enable Dovecot to listen for <abbr title="Internet Protocol Version 6" class="initialism">IPv6</abbr> Address requests.</p>
            <p><strong>Note</strong>: You must select a protocol in the Protocols Enabled section before selecting IPv6 Enabled.</p>
        </td>
    </tr>

    <tr>
        <td>
            <label class="label_title">Allow Plaintext Authentication (from remote clients)</label>
            <select name="enable_plaintext_auth" id="enable_plaintext_auth">
            
                <option selected="selected" value="yes">Yes</option>
            
                <option value="no">No</option>
            
            </select>
            <p>This setting will allow remote email clients to authenticate using unencrypted connections. When set to “no”, only connections originating on the local server will be allowed to authenticate without encryption. Selecting “no” is preferable to disabling <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> in the <em>Protocols Enabled</em> section since it will force remote users to use encryption while still allowing webmail to function correctly.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title"><abbr title="Secure Socket Layer" class="initialism">SSL</abbr> Cipher List</label>
            <input type="text" name="ssl_cipher_list" id="ssl_cipher_list" value="ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384"> <span id="ssl_cipher_list_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>This is a standard format list of the <abbr title="Secure Socket Layer" class="initialism">SSL</abbr> ciphers Dovecot should use. Typically this will only need to be adjusted for <abbr title="Payment Card Industry" class="initialism">PCI</abbr> compliance."
            <!--<span id="example_ssl_cipher_link" class="action_link">see example</span>--></p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title"><abbr title="Secure Socket Layer" class="initialism">SSL</abbr> Minimum Protocol</label>
            <select name="ssl_min_protocol" id="ssl_min_protocol">
            
                <option value="SSLv3">SSLv3</option>
            
                <option value="TLSv1">TLSv1</option>
            
                <option value="TLSv1.1">TLSv1.1</option>
            
                <option selected="selected" value="TLSv1.2">TLSv1.2</option>
            
            </select>
            <p>This value represents the minimum <abbr title="Secure Socket Layer" class="initialism">SSL</abbr> protocol that Dovecot clients may use to connect. Typically, you will only need to adjust this value for <abbr title="Payment Card Industry" class="initialism">PCI</abbr> compliance.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Maximum Number of Mail Processes</label>
            <input type="text" name="max_mail_processes" id="max_mail_processes" value="512"> <span id="max_mail_processes_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>Specifies the maximum number of mail (<abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> and <abbr title="Post Office Protocol" class="initialism">POP3</abbr> servers) processes that may be running at one time.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Process Memory Limit for Mail (<abbr title="Megabytes">MB</abbr>)</label>
            <input type="text" name="mail_process_size" id="mail_process_size" value="512"> <span id="mail_process_size_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum memory usage of the <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> and <abbr title="Post Office Protocol" class="initialism">POP3</abbr> processes, in <abbr title="Megabytes" class="initialism">MB</abbr>. These processes read mostly memory-mapped files, so setting a high limit should not affect your server’s performance.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Maximum <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> Connections Per IP Address</label>
            <input type="text" name="protocol_imap.mail_max_userip_connections" id="protocol_imap.mail_max_userip_connections" value="20"> <span id="protocol_imap.mail_max_userip_connections_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>Specifies the number of simultaneous <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> connections that a single user (<abbr title="Internet Protocol" class="initialism">IP</abbr> address) may make from each IP address.</p>
        </td>
    </tr>
   <tr>
        <td>
            <label class="label_title">Interval between <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> IDLE “OK Still here” messages.</label>
            <input type="text" name="protocol_imap.imap_idle_notify_interval" id="protocol_imap.imap_idle_notify_interval" value="24"> <span id="protocol_imap.imap_idle_notify_interval_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>Specifies the number of minutes between <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> IDLE “OK Still here” messages. Increasing this may help increase battery life for some mobile clients.</p>
        </td>
    </tr>

    <tr>
        <td>
            <label class="label_title">Maximum <abbr title="Post Office Protocol" class="initialism">POP3</abbr> Connections per <abbr title="Internet Protocol" class="initialism">IP</abbr> Address</label>
            <input type="text" name="protocol_pop3.mail_max_userip_connections" id="protocol_pop3.mail_max_userip_connections" value="3"> <span id="protocol_pop3.mail_max_userip_connections_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>Specifies the number of simultaneous <abbr title="Post Office Protocol" class="initialism">POP3</abbr> connections that a single user (IP address) may make from each IP address.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Number of Spare Authentication Processes</label>
            <input type="text" name="login_processes_count" id="login_processes_count" value="2"> <span id="login_processes_count_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>This specifies how many spare authentication processes should be kept running to listen for new connections.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Maximum Number of Authentication Processes</label>
            <input type="text" name="login_max_processes_count" id="login_max_processes_count" value="50"> <span id="login_max_processes_count_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>Specifies the maximum number of authentication processes that may be running at one time.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Process Memory Limit for Authentication (<abbr title="Megabytes">MB</abbr>)</label>
            <input type="text" name="login_process_size" id="login_process_size" value="128"> <span id="login_process_size_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum memory usage of the <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> and <abbr title="Post Office Protocol" class="initialism">POP3</abbr> login processes, in <abbr title="Megabytes" class="initialism">MB</abbr>.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Idle Hibernate Timeout (Seconds)</label>
            <input type="text" name="imap_hibernate_timeout" id="imap_hibernate_timeout" value="30"> <span id="imap_hibernate_timeout_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The number of seconds to delay before moving users to the IMAP hibernate process. This will help save system memory. A value of “0” disables this option.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Size of Authentication Cache (<abbr title="Megabytes">MB</abbr>)</label>
            <input type="text" name="auth_cache_size" id="auth_cache_size" value="1M"> <span id="auth_cache_size_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The master authentication process keeps a cache of validated logins so that it does not need to recheck the login credentials each time mail is retrieved. This specifies the amount of memory used for the cache, in <abbr title="Megabytes">MB</abbr>.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Time to Cache Successful Logins</label>
            <input type="text" name="auth_cache_ttl" id="auth_cache_ttl" value="3600"> <span id="auth_cache_ttl_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The time, in seconds, that successful logins will be stored in the authentication cache. A lower value may cause more work for the authentication server but decrease the likelihood of problems when passwords are updated.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Time to Cache Failed Logins</label>
            <input type="text" name="auth_cache_negative_ttl" id="auth_cache_negative_ttl" value="3600"> <span id="auth_cache_negative_ttl_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The time in seconds that failed logins will be stored in the authentication cache. Lowering this value may cause more work for the authentication server but decrease the likelihood of problems when passwords are updated.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Use New Authentication Process for Each Connection</label>
            <select name="login_process_per_connection" id="login_process_per_connection">
            
                <option value="yes">Yes</option>
            
                <option selected="selected" value="no">No</option>
            
            </select>
            <p>Specifies whether to use a new login process for each new <abbr title="Post Office Protocol" class="initialism">POP3</abbr> or <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> connection. Setting this to yes may improve the security of the Dovecot authentication processes, but doing so imposes a significant performance penalty on heavily loaded servers.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Process Memory Limit: config (<abbr title="Megabytes">MB</abbr>)</label>
            <input type="text" name="config_vsz_limit" id="config_vsz_limit" value="2048"> <span id="config_vsz_limit_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum memory usage (in <abbr title="Megabytes">MB</abbr>) of Dovecot’s internal “config” service. Each SSL/TLS certificate that Dovecot tracks requires additional memory. Servers with many domains may need to increase this value to ensure that Dovecot operates correctly.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Idle Check Interval</label>
            <input type="text" name="mailbox_idle_check_interval" id="mailbox_idle_check_interval" value="30"> <span id="mailbox_idle_check_interval_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The time in seconds between updates to idle <abbr title="Internet Message Access Protocol" class="initialism">IMAP</abbr> connections. Lowering this value will cause idle clients to see new messages faster, however lower values may also increase server load slightly. The default setting of 30 is recommended.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Include Trash in Quota</label>
            <input type="checkbox" name="include_trash_in_quota" id="include_trash_in_quota" value="1"> <span id="include_trash_in_quota_error"></span>
            <p>When this option is enabled, the system will count email messages in the Trash folder against the user’s quota.
            Note: In order to recalculate existing quotas, you must run the “/usr/local/cpanel/scripts/generate_maildirsize --allaccounts --confirm” command in a root shell after you modify this option.
          </p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Compress Messages</label>
            <input type="checkbox" name="compress_messages" id="compress_messages" value="1"> <span id="compress_messages_error"></span>
            <p>When you enable this option, the system will compress recently created and delivered messages.</p>
          <p></p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Compression Level</label>
            <input type="text" name="compress_messages_level" id="compress_messages_level" value="6" disabled=""> <span id="compress_messages_level_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The compression level to save messages in when you enable “Compress Messages”.</p>
        </td>
    </tr>

    <tr>
        <td>
            <label class="label_title">Auto Expunge Trash</label>
            <input type="checkbox" name="expire_trash" id="expire_trash" value="1"> <span id="expire_trash_error"></span>
            <p>When this option is enabled, the system will remove messages in the Trash and Deleted Messages folders based on the expiration time configured below.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Trash Expire Time</label>
            <input type="text" name="expire_trash_ttl" id="expire_trash_ttl" value="30" disabled=""> <span id="expire_trash_ttl_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The number of days to keep messages before the <em>Auto Expunge Trash</em> function removes them. This function only works if the <em>Auto Expunge Trash</em> function is enabled.</p>
        </td>
    </tr>

    <tr>
        <td>
            <label class="label_title">Auto Expunge Spam</label>
            <input type="checkbox" name="expire_spam" id="expire_spam" value="1"> <span id="expire_spam_error"></span>
            <p>When this option is enabled, the system will remove messages in the Spam folder based on the expiration time configured below.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Spam Expire Time</label>
            <input type="text" name="expire_spam_ttl" id="expire_spam_ttl" value="30" disabled=""> <span id="expire_spam_ttl_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The number of days to keep messages before the <em>Auto Expunge Spam</em> function removes them. This function only works if the <em>Auto Expunge Spam</em> function is enabled.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">MDBOX rotation size (<abbr title="Megabytes" class="initialism">MB</abbr>)</label>
            <input type="text" name="mdbox_rotate_size" id="mdbox_rotate_size" value="10M"> <span id="mdbox_rotate_size_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum size to which a MDBOX mailbox file may grow before the system rotates it.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">MDBOX rotation interval (Weeks or Days)</label>
            <input type="text" name="mdbox_rotate_interval" id="mdbox_rotate_interval" value="0"> <span id="mdbox_rotate_interval_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum time that an MDBOX mailbox file may exist before the system rotates it.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Disk Quota Delivery Failure Response</label>
            <p class="distinct"><label>How Dovecot will respond when a system disk quota or mailbox disk quota prevents delivery:</label></p>
                            <p class="distinct">
                    <label><input type="radio" name="incoming_reached_quota" value="bounce" checked=""> Reject the message permanently.</label>
                    <span class="help_hover_wrapper">
                        <a href="javascript:void(0)" class="help_hover">[ ? ]</a>
                        <span class="help_text">This option reduces mail overhead.</span>
                    </span>
                </p>
                            <p class="distinct">
                    <label><input type="radio" name="incoming_reached_quota" value="defer"> Defer delivery temporarily.</label>
                    <span class="help_hover_wrapper">
                        <a href="javascript:void(0)" class="help_hover">[ ? ]</a>
                        <span class="help_text">This option allows the user time to reduce disk usage and to receive the message.</span>
                    </span>
                </p>
                    </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">Minimum Available LMTP Processes</label>
            <input type="text" name="lmtp_process_min_avail" id="lmtp_process_min_avail" value="0"> <span id="lmtp_process_min_avail_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The minimum number of processes that the system will attempt to reserve in order to accept more client connections.
               A setting of 0 will only start the LMTP server when needed and will conserve memory.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">LMTP Process Limit</label>
            <input type="text" name="lmtp_process_limit" id="lmtp_process_limit" value="500"> <span id="lmtp_process_limit_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum number of LMTP server processes.</p>
        </td>
    </tr>
    <tr>
        <td>
            <label class="label_title">LMTP User Concurrency Limit</label>
            <input type="text" name="lmtp_user_concurrency_limit" id="lmtp_user_concurrency_limit" value="4"> <span id="lmtp_user_concurrency_limit_error" class="cjt_validation_error" style="width: 16px; height: 16px;"></span>
            <p>The maximum number of concurrent LMTP deliveries per user. A value of “0” disables the per-user limit.</p>
        </td>
    </tr>
</tbody></table>
<br>
<table style="width: 570px">
    <tbody><tr>
        <td><input type="button" value="Use Default Values" id="use_defaults" class="btn btn-default"></td>
        <td style="text-align: right">
            <span id="reset_form" class="action_link">Reset Form</span><input type="submit" value="Save Changes" id="submit_page" class="btn btn-primary">
        </td>
    </tr>
</tbody></table>
<br>
</form>