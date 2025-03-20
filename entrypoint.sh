#!/usr/bin/env bash

set -e

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

chown -R oneadmin:oneadmin /var/log/one /var/lib/one /etc/one /run/one/ /run/lock/one


exec gosu oneadmin:oneadmin /oneadmin.sh "$@"
