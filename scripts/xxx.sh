#!/usr/bin/env bash

BACKUP_DIR="/root/security_backup_$(date +%Y%m%d_%H%M%S)"
backup_files() {
    sudo mkdir -p "$BACKUP_DIR" || handle_error "Failed to create backup directory"

    local files_to_backup=(
        "/etc/default/grub"
        "/etc/ssh/sshd_config"
        "/etc/pam.d/common-password"
        "/etc/login.defs"
        "/etc/sysctl.conf"
        "/etc/my.cnf"
    )

    for file in "${files_to_backup[@]}"; do
        if [ -f "$file" ]; then
            sudo cp "$file" "$BACKUP_DIR/" || log "Warning: Failed to backup $file"
        else
            log "Warning: $file not found, skipping backup"
        fi
    done

    log "Backup created in $BACKUP_DIR"
}
restore_backup() {
    if [ -d "$BACKUP_DIR" ]; then
        for file in "$BACKUP_DIR"/*; do
            sudo cp "$file" "$(dirname "$(readlink -f "$file")")" || log "Warning: Failed to restore $(basename "$file")"
        done
        log "Restored configurations from $BACKUP_DIR"
    else
        log "Backup directory not found. Cannot restore."
    fi
}
#backup_files
restore_backup
exit
sed -ie '0,/#PermitRootLogin prohibit-password/s/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
service sshd restart
sed '/[mysqld]/a bind-address = 0.0.0.0' /etc/my.cnf
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf
echo "Updating mysql configs in /etc/my.cnf."

if [ 'sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf' ]; then

    echo "Updated mysql bind address in /etc/my.cnf to 0.0.0.0 to allow external connections."

    sudo /etc/init.d/mysql stop
    sudo /etc/init.d/mysql start

fi