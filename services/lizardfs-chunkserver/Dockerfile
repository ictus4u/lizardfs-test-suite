ARG LIZARD_BASE_REPOSITORY="registry.lizardfs.com/baldor/lizardfs-base:latest"

FROM ${LIZARD_BASE_REPOSITORY}

RUN set -ex ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    lizardfs-common \
    lizardfs-chunkserver ; \
    rm -rf /var/lib/apt/lists/*


EXPOSE 9422

VOLUME [ "/config" ]

COPY ./docker/docker_entrypoint.sh /
ENTRYPOINT [ "/usr/bin/tini", "--", "/docker_entrypoint.sh" ]

CMD [ "/usr/sbin/mfschunkserver", "-d", "-u", "start" ]
