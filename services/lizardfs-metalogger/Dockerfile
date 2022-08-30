ARG LIZARD_BASE_REPOSITORY="registry.lizardfs.com/baldor/lizardfs-base:latest"

FROM ${LIZARD_BASE_REPOSITORY}

RUN set -ex ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    lizardfs-common \
    lizardfs-metalogger ; \
    rm -rf /var/lib/apt/lists/*

VOLUME [ "/config" ]

COPY ./docker/docker_entrypoint.sh /
ENTRYPOINT [ "/usr/bin/tini", "--", "/docker_entrypoint.sh" ]

CMD [ "/usr/sbin/mfsmetalogger", "-du", "start" ]
