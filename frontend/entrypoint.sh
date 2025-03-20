#!/usr/bin/env bash

set -e

case $1 in
  init)
    exec /init.sh
  ;;
  *)
    exec gosu oneadmin:oneadmin /oneadmin.sh "$@"
  ;;
esac

