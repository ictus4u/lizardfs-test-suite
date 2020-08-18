ARG LIZARD_BASE_REPOSITORY="ictus4u/lizardfs-base:latest"
ARG LIZARD_DIST_REPOSITORY="ictus4u/lizardfs-dist:latest"

FROM ${LIZARD_DIST_REPOSITORY} as build-stage

FROM ${LIZARD_BASE_REPOSITORY}

COPY --from=build-stage /lizardfs-modules/lizardfs-common /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-master /tmp/install/

EXPOSE 9419 9420 9424 9421

CMD [ "/usr/sbin/mfsmaster", "-du", "start" ]
