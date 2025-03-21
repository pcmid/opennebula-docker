#!/usr/bin/env bash

set -e

case $1 in
  init)
    exec /init.sh
  ;;
  sshd)
    mkdir -p /var/run/sshd
    exec /usr/sbin/sshd -D
  ;;
  *)
    exec gosu oneadmin:oneadmin /oneadmin.sh "$@"
  ;;
esac

