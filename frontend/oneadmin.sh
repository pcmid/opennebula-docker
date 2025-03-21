#!/usr/bin/env bash
set -e

case $1 in
  oned)
    /usr/bin/oned
    until [ -f /var/log/one/oned.log ]; do sleep 1; done
    tail -f /var/log/one/oned.log &
    trap 'rm -f /run/lock/one/one; exit 0' TERM INT EXIT
    wait
    ;;
  scheduler)
    /usr/bin/mm_sched &
    until [ -f /var/log/one/sched.log ]; do sleep 1; done
    tail -f /var/log/one/sched.log &
    trap 'exit 0' TERM INT EXIT
    wait
    ;;
  onehem)
    /usr/bin/onehem-server start
    until [ -f /var/log/one/onehem.log ]; do sleep 1; done
    tail -f /var/log/one/onehem.log &
    trap "rm -f /run/lock/one/.onehem.lock; rm -f /run/one/onehem.pid; exit 0" TERM INT EXIT
    wait
    ;;
  oneflow)
    /usr/bin/oneflow-server start
    until [ -f /var/log/one/oneflow.log ]; do sleep 1; done
    tail -f /var/log/one/oneflow.log &
    trap "rm -f /run/lock/one/.oneflow.lock; rm -f /run/one/oneflow.pid; exit 0" TERM INT EXIT
    wait
    ;;
  onegate)
    /usr/bin/onegate-server start
    until [ -f /var/log/one/onegate.log ]; do sleep 1; done
    tail -f /var/log/one/onegate.log &
    trap "rm -f /run/lock/one/.onegate.lock; rm -f /run/one/onegate.pid; exit 0" TERM INT EXIT
    wait
    ;;
  fireedge)
    LD_LIBRARY_PATH=/usr/share/one/guacd/lib /usr/share/one/guacd/sbin/guacd $OPTS
    node /usr/lib/one/fireedge/dist/index.js >>/var/log/one/fireedge.log 2>>/var/log/one/fireedge.error &
    until [ -f /var/log/one/fireedge.log ]; do sleep 1; done
    tail -f /var/log/one/fireedge.log &
    trap "rm -f /run/lock/one/.fireedge.lock; rm -f /run/one/fireedge.pid; rm -f /run/one/guacd.pid; exit 0" TERM INT EXIT
    wait
    ;;
  *)
    exec "$@"
    ;;
esac
