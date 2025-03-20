# OpenNebula Node

# WIP

```bash
docker run -it --name node-kvm --rm --network host --privileged \
  -v /sys/fs/cgroup:/sys/fs/cgroup --cgroupns=host --cap-add ALL \
  -v /etc/one:/etc/one:ro \
  -v /var/log/one:/var/log/one \
  -v /var/lib/one:/var/lib/one \
  -v /run/one:/run/one \
  -v /run/lock/one:/run/lock/one \
  -v $(pwd)/one/ssh:/etc/ssh \
  -v /dev/kvm:/dev/kvm \
  -v /dev/snd:/dev/snd \
   opennebula-node
```