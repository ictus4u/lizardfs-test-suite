ARG LIZARD_RELEASE_REPOSITORY=ictus4u/lizardfs-dist:latest

FROM ${LIZARD_RELEASE_REPOSITORY} as lizardfs-release

FROM jrei/systemd-ubuntu:20.04
USER root
WORKDIR /root/
COPY --from=lizardfs-release /lizardfs-common/ ./
COPY --from=lizardfs-release  /lizardfs-master/ ./

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="UTC"
## lizardfs-master
EXPOSE 9419 9420 9424 9421

RUN sed -i 's@^path-exclude=/usr/share/doc/\*$@#\0@' /etc/dpkg/dpkg.cfg.d/excludes \
  && dpkg -i \
    lizardfs-common_* \
    lizardfs-master_* \
  && sed -i 's/LIZARDFSMASTER_ENABLE=false/LIZARDFSMASTER_ENABLE=true/' /etc/default/lizardfs-master \
  && cp -a /usr/share/doc/lizardfs-master/examples/*.cfg /etc/lizardfs/ \
  && cp -a /var/lib/lizardfs/metadata.mfs.empty /var/lib/lizardfs/metadata.mfs
