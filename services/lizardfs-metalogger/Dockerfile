ARG LIZARD_BASE_REPOSITORY="ictus4u/lizardfs-base:latest"
ARG LIZARD_DIST_REPOSITORY="ictus4u/lizardfs-dist:latest"

FROM ${LIZARD_DIST_REPOSITORY} as build-stage

FROM ${LIZARD_BASE_REPOSITORY}

COPY --from=build-stage /lizardfs-modules/lizardfs-common /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-metalogger /tmp/install/

CMD [ "/usr/sbin/mfsmetalogger", "-du", "start" ]
