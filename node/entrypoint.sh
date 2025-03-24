#!/usr/bin/env bash

set -e

if [ -z "$(ls -A /var/lib/one)" ]; then
  echo "Initializing OpenNebula data..."
  cp -r /var/lib/one.dist/* /var/lib/one/
  cp -r /var/lib/one.dist/.one /var/lib/one/
  echo 'oneadmin:oneadmin' >> /var/lib/one/.one/one_auth
  echo ">> You must edit the password in /var/lib/one/.one/one_auth"
fi

chown -R oneadmin:oneadmin /var/log/one /var/lib/one /etc/one /run/one/ /run/lock/one

if [ ! -s /etc/ssh/sshd_config ]; then
  echo "Initializing SSH configuration..."
  cat > /etc/ssh/sshd_config <<EOF
Port 2201
PermitRootLogin no
PasswordAuthentication no
AuthorizedKeysFile .ssh/authorized_keys
UsePAM yes
UseDNS no
EOF
fi

cat > /etc/ssh/ssh_config <<EOF
Host *
    StrictHostKeyChecking accept-new
EOF

if [[ ! -f /etc/ssh/ssh_host_ecdsa_key ||
      ! -f /etc/ssh/ssh_host_ecdsa_key.pub ||
      ! -f /etc/ssh/ssh_host_ed25519_key ||
      ! -f /etc/ssh/ssh_host_ed25519_key.pub ||
      ! -f /etc/ssh/ssh_host_rsa_key ||
      ! -f /etc/ssh/ssh_host_rsa_key.pub ]]; then
   ssh-keygen -A
fi

exec "$@"

