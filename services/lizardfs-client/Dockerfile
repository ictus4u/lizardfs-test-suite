ARG LIZARD_BASE_REPOSITORY="registry.lizardfs.com/baldor/lizardfs-base:latest"

FROM ${LIZARD_BASE_REPOSITORY}

RUN set -ex ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    bash-completion \
    fuse3>=3.2.3 \
    lizardfs-adm \
    lizardfs-client3 ; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mnt/lizardfs

VOLUME [ "/config" ]

COPY ./docker/docker_entrypoint.sh /
ENTRYPOINT [ "/usr/bin/tini", "--", "/docker_entrypoint.sh" ]

CMD ["mfsmount3", "-f", "/mnt/lizardfs"]
