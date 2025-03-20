if [ -z "$(ls -A /etc/one)" ]; then
  echo "Initializing OpenNebula configuration..."
  cp -r /etc/one.dist/* /etc/one/
fi

if [ -z "$(ls -A /var/lib/one)" ]; then
  echo "Initializing OpenNebula data..."
  cp -r /var/lib/one.dist/* /var/lib/one/
  cp -r /var/lib/one.dist/.one /var/lib/one/
  echo 'oneadmin:0neadm1n' >> /var/lib/one/.one/one_auth
  echo ">> You must edit the password in /var/lib/one/.one/one_auth"
fi

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

# Generate Ed25519 key for oneadmin user
if [[ ! -f /var/lib/one/.ssh/id_ed25519 ]]; then
  echo "Generating Ed25519 key for oneadmin..."
  mkdir -p /var/lib/one/.ssh
  ssh-keygen -t ed25519 -f /var/lib/one/.ssh/id_ed25519 -N "" -q
  cat /var/lib/one/.ssh/id_ed25519.pub >> /var/lib/one/.ssh/authorized_keys
  chmod 600 /var/lib/one/.ssh/authorized_keys
  chmod 700 /var/lib/one/.ssh
  chown -R oneadmin:oneadmin /var/lib/one/.ssh
fi

chown -R oneadmin:oneadmin /var/log/one /var/lib/one /etc/one /run/one/ /run/lock/one
