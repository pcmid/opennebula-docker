FROM debian:12-slim

ENV container=docker
ENV LC_ALL=C
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install gnupg wget apt-transport-https systemd-standalone-tmpfiles gosu \
    && wget -q -O- https://downloads.opennebula.io/repo/repo2.key | gpg --dearmor --yes --output /etc/apt/keyrings/opennebula.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/opennebula.gpg] https://downloads.opennebula.io/repo/6.10/Debian/12 stable opennebula" > /etc/apt/sources.list.d/opennebula.list \
    && apt-get update \
    && apt-get -y install opennebula opennebula-fireedge opennebula-gate opennebula-flow opennebula-provision \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && cp -r /etc/one /etc/one.dist \
    && cp -r /var/lib/one /var/lib/one.dist

COPY entrypoint.sh /entrypoint.sh
COPY oneadmin.sh /oneadmin.sh
COPY init.sh /init.sh

ENTRYPOINT ["/entrypoint.sh"]
