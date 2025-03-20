#!/usr/bin/env bash
set -e

case $1 in
  oned)
    /usr/bin/oned
    tail -f /var/log/one/oned.log &
    trap 'rm -f /run/lock/one/one; exit 0' TERM INT EXIT
    wait
    ;;
  scheduler)
    /usr/bin/mm_sched &
    tail -f /var/log/one/sched.log &
    trap 'exit 0' TERM INT EXIT
    wait
    ;;
  onehem)
    /usr/bin/onehem-server start
    tail -f /var/log/one/onehem.log &
    trap "rm -f /run/lock/one/.onehem.lock; rm -f /run/one/onehem.pid; exit 0" TERM INT EXIT
    wait
    ;;
  oneflow)
    /usr/bin/oneflow-server start
    tail -f /var/log/one/oneflow.log &
    trap "rm -f /run/lock/one/.oneflow.lock; rm -f /run/one/oneflow.pid; exit 0" TERM INT EXIT
    wait
    ;;
  onegate)
    /usr/bin/onegate-server start
    tail -f /var/log/one/onegate.log &
    trap "rm -f /run/lock/one/.onegate.lock; rm -f /run/one/onegate.pid; exit 0" TERM INT EXIT
    wait
    ;;
  fireedge)
    /usr/bin/fireedge-server start
    tail -f /var/log/one/fireedge.log &
    trap "rm -f /run/lock/one/.fireedge.lock; rm -f /run/one/fireedge.pid; rm -f /run/one/guacd.pid; exit 0" TERM INT EXIT
    wait
    ;;
  *)
    exec "$@"
    ;;
esac
