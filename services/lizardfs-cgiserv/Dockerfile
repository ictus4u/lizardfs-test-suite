ARG LIZARD_BASE_REPOSITORY="ictus4u/lizardfs-base:latest"
ARG LIZARD_DIST_REPOSITORY="ictus4u/lizardfs-dist:latest"

FROM ${LIZARD_DIST_REPOSITORY} as build-stage

FROM ${LIZARD_BASE_REPOSITORY}

ARG BIND_HOST=0.0.0.0
ARG BIND_PORT=9425
ARG ROOT_PATH=/usr/share/mfscgi
ARG ENVIRONMENT_FILE=/etc/default/lizardfs-cgiserv

ENV BIND_HOST=${BIND_HOST}
ENV BIND_PORT=${BIND_PORT}
ENV ROOT_PATH=${ROOT_PATH}
ENV ENVIRONMENT_FILE=${ENVIRONMENT_FILE}

COPY --from=build-stage /lizardfs-modules/lizardfs-cgi /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-cgiserv /tmp/install/

EXPOSE 9425

RUN apt-get update \
    && apt-get install -y python3 \
    && dpkg -i  /tmp/install/lizardfs-*.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD /usr/sbin/lizardfs-cgiserver -H ${BIND_HOST} -P ${BIND_PORT} -R ${ROOT_PATH}
