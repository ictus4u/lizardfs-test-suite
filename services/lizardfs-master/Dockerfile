ARG LIZARD_BASE_REPOSITORY="registry.lizardfs.com/baldor/lizardfs-base:latest"

FROM ${LIZARD_BASE_REPOSITORY}

RUN set -ex ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    lizardfs-common=3.12.0 \
    lizardfs-master=3.12.0 ; \
    rm -rf /var/lib/apt/lists/* ;

RUN cp /etc/mfs/*.cfg.dist /tmp/ ; \
    cp /var/lib/mfs/metadata.mfs.empty /tmp/ ;

EXPOSE 9419 9420 9424 9421

VOLUME [ "/config" ]

COPY ./docker/docker_entrypoint.sh /
ENTRYPOINT [ "/usr/bin/tini", "--", "/docker_entrypoint.sh" ]

CMD [ "/usr/sbin/mfsmaster", "-d", "-u", "start" ]
