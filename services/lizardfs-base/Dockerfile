ARG BASE_IMAGE=debian:bullseye
FROM ${BASE_IMAGE}
ARG DEBIAN_FRONTEND=noninteractive
ENV LC_ALL="C"
ENV TZ="UTC"

RUN set -ex ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    lsb-release \
    tini ; \
    mkdir -p /root/.gnupg ; \
    chmod -R u+rwX,go= /root/.gnupg ; \
    mkdir -p /usr/share/keyrings ; \
    gpg --no-default-keyring --keyring /usr/share/keyrings/lizardfs-archive-keyring.gpg --keyserver hkps://keyserver.ubuntu.com --receive-keys 0x87026F04A1B61746 ; \
    chmod 644 /usr/share/keyrings/lizardfs-archive-keyring.gpg ; \
    echo "deb [signed-by=/usr/share/keyrings/lizardfs-archive-keyring.gpg] https://dev.lizardfs.com/packages bullseye/" | tee /etc/apt/sources.list.d/lizardfs.list > /dev/null ;\
    chmod 644 /etc/apt/sources.list.d/lizardfs.list ; \
    rm -rf /var/lib/apt/lists/*
