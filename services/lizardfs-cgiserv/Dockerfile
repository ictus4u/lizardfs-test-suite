ARG LIZARD_BASE_REPOSITORY="registry.lizardfs.com/baldor/lizardfs-base:latest"

FROM ${LIZARD_BASE_REPOSITORY}

ARG BIND_HOST=0.0.0.0
ARG BIND_PORT=9425
ARG ROOT_PATH=/usr/share/mfscgi
ARG ENVIRONMENT_FILE=/etc/default/lizardfs-cgiserv

RUN set -ex ; \
    apt-get update; \
    apt-get install -y \
    lizardfs-cgi \
    lizardfs-cgiserv ; \
    rm -rf /var/lib/apt/lists/*

ENV BIND_HOST=${BIND_HOST}
ENV BIND_PORT=${BIND_PORT}
ENV ROOT_PATH=${ROOT_PATH}
ENV ENVIRONMENT_FILE=${ENVIRONMENT_FILE}

EXPOSE 9425

VOLUME [ "/config" ]

COPY ./docker/docker_entrypoint.sh /
ENTRYPOINT [ "/usr/bin/tini", "--", "/docker_entrypoint.sh" ]

CMD /usr/sbin/lizardfs-cgiserver -H ${BIND_HOST} -P ${BIND_PORT} -R ${ROOT_PATH}
