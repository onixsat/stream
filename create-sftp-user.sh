#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Please provide a username as an argument."
  exit 1
fi

username=$1

sudo adduser --shell /bin/false --disabled-password --gecos "" $username

echo "Enter the password for the user '$username':"
read -s password
echo

echo "$username:$password" | sudo chpasswd

sftp_directory="/var/sftp"
user_directory="$sftp_directory/$username"
sudo mkdir -p "$user_directory"
sudo chown root:root "$sftp_directory"
sudo chown $username:$username "$user_directory"
sudo chmod 777 "$sftp_directory"
sudo chmod 777 "$user_directory"

sudo tee -a /etc/ssh/sshd_config > /dev/null <<EOL
Match User $username
	ForceCommand internal-sftp
	PasswordAuthentication yes
	ChrootDirectory $sftp_directory
	PermitTunnel no
	AllowAgentForwarding no
	AllowTcpForwarding no
	X11Forwarding no
EOL

sudo systemctl restart ssh

echo "SFTP user '$username' created with the provided password and separate directory."
