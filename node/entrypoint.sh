#!/usr/bin/env bash

set -e

if [ -z "$(ls -A /var/lib/one)" ]; then
  echo "Initializing OpenNebula data..."
  cp -r /var/lib/one.dist/* /var/lib/one/
  cp -r /var/lib/one.dist/.one /var/lib/one/
  echo 'oneadmin:0neadm1n' >> /var/lib/one/.one/one_auth
  echo ">> You must edit the password in /var/lib/one/.one/one_auth"
fi

chown -R oneadmin:oneadmin /var/log/one /var/lib/one /etc/one /run/one/ /run/lock/one

if [ ! -s /etc/ssh/sshd_config ]; then
    cat > /etc/ssh/sshd_config <<EOF
Port 2222
UsePAM yes
EOF
fi

if [[ ! -f /etc/ssh/ssh_host_ecdsa_key ||
      ! -f /etc/ssh/ssh_host_ecdsa_key.pub ||
      ! -f /etc/ssh/ssh_host_ed25519_key ||
      ! -f /etc/ssh/ssh_host_ed25519_key.pub ||
      ! -f /etc/ssh/ssh_host_rsa_key ||
      ! -f /etc/ssh/ssh_host_rsa_key.pub ]]; then
   ssh-keygen -A
fi

exec "$@"

