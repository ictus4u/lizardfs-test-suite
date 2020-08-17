ARG LIZARD_BASE_REPOSITORY="ictus4u/lizardfs-base:latest"
ARG LIZARD_DIST_REPOSITORY="ictus4u/lizardfs-dist:latest"

FROM ${LIZARD_DIST_REPOSITORY} as build-stage

FROM ${LIZARD_BASE_REPOSITORY}

#COPY --from=build-stage /lizardfs-modules/lizardfs-adm /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-chunkserver /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-cgi /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-cgiserv /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-client /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-client3 /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-common /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-dbg /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-lib-client /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-master /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-metalogger /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-nfs-ganesha /tmp/install/
#COPY --from=build-stage /lizardfs-modules/lizardfs-uraft /tmp/install/

EXPOSE 9419 9420 9424 9421

CMD [ "/usr/sbin/mfsmaster", "-d" ]
