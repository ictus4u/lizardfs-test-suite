FROM ubuntu:20.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's@^path-exclude=/usr/share/doc/\*$@#\0@' /etc/dpkg/dpkg.cfg.d/excludes

ONBUILD COPY ./docker/docker_entrypoint.sh /

ONBUILD ENTRYPOINT ["/docker_entrypoint.sh"]

VOLUME [ "/mnt/config" , "/mnt/install" ]
