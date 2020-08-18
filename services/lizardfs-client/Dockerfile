ARG LIZARD_BASE_REPOSITORY="ictus4u/lizardfs-base:latest"
ARG LIZARD_DIST_REPOSITORY="ictus4u/lizardfs-dist:latest"

FROM ${LIZARD_DIST_REPOSITORY} as build-stage

FROM ${LIZARD_BASE_REPOSITORY}

COPY --from=build-stage /lizardfs-modules/lizardfs-client /tmp/install/

RUN apt-get update \
    && apt-get install -y \
      fuse>=2.8 \
      bash-completion \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER root

CMD tail -f /dev/null
