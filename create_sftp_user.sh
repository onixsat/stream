# usage: create_sftp_user <username>
function create_sftp_user() {
    # create user
    sudo adduser --disabled-password --gecos "" $1

    # prevent ssh login & assign SFTP group
    sudo usermod -g sftpaccess $1
    sudo usermod -s /bin/nologin $1

    # chroot user (so they only see their directory after login)
    sudo chown root:$1 /home/$1
    sudo chmod 777 /home/$1

    sudo mkdir /home/$1/data
    sudo chown $1:$1 /home/$1/data
    sudo chmod 777 /home/$1/data

    sudo mkdir /home/$1/.ssh
    sudo chown $1:$1 /home/$1/.ssh
    sudo chmod 755 /home/$1/.ssh

    sudo ssh-keygen -f /home/$1/.ssh/id_rsa -C "$1@client-data" -N ""
    sudo chown $1:$1 /home/$1/.ssh/id_rsa
    sudo chmod 600 /home/$1/.ssh/id_rsa
    sudo chown $1:$1 /home/$1/.ssh/id_rsa.pub
    sudo chmod 644 /home/$1/.ssh/id_rsa.pub

    sudo touch /home/$1/.ssh/authorized_keys
    sudo chown $1:$1 /home/$1/.ssh/authorized_keys
    sudo chmod 666 /home/$1/.ssh/authorized_keys
    sudo cat /home/$1/.ssh/id_rsa.pub >> /home/$1/.ssh/authorized_keys
    sudo chmod 644 /home/$1/.ssh/authorized_keys
}
