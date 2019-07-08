#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

AUTH_KEY=$(jq --raw-output ".auth_key" $CONFIG_PATH)

adduser -h /home/tunnel -s /bin/false -D tunnel
passwd -u tunnel
mkdir -p /home/tunnel/.ssh
echo "$AUTH_KEY" > /home/tunnel/.ssh/authorized_keys
chown tunnel:tunnel -R /home/tunnel/.ssh
chmod 700 /home/tunnel/.ssh
chmod 600 /home/tunnel/.ssh/*

sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config
sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ no/ /etc/ssh/sshd_config
sed -i s/#PermitEmptyPasswords.*/PermitEmptyPasswords\ no/ /etc/ssh/sshd_config
printf "\nMatch User tunnel\n   AllowTcpForwarding yes\n   X11Forwarding no\n" >> /etc/ssh/sshd_config


if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    echo "Generating host keys..."
    ssh-keygen -A
fi

echo "Starting server..."
exec /usr/sbin/sshd -D -e




