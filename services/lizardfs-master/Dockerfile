ARG LIZARD_BASE_REPOSITORY="registry.lizardfs.com/baldor/lizardfs-base:latest"

FROM ${LIZARD_BASE_REPOSITORY}

RUN set -ex ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    lizardfs-common \
    lizardfs-master ; \
    rm -rf /var/lib/apt/lists/* ;

RUN cp /etc/lizardfs/*.cfg.dist /tmp/ ; \
    cp /var/lib/lizardfs/metadata.mfs.empty /tmp/ ;

EXPOSE 9419 9420 9424 9421

VOLUME [ "/config" ]

COPY ./docker/docker_entrypoint.sh /
ENTRYPOINT [ "/usr/bin/tini", "--", "/docker_entrypoint.sh" ]

CMD [ "/usr/sbin/mfsmaster", "-d", "-u", "start" ]
