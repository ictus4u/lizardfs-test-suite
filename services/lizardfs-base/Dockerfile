FROM ubuntu:20.04 as build-stage

USER root

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="UTC"

RUN apt-get update && apt-get install -y --no-install-recommends \
    asciidoc \
    apt-utils \
    build-essential \
    cmake \
    debhelper \
    dpkg-dev \
    docbook-xsl \
    git \
    libboost-program-options-dev \
    libboost-system-dev \
    libfmt-dev \
    libfuse3-dev \
    libfuse-dev \
    libspdlog-dev \
    libxml2-utils \
    libxslt1-dev \
    lsb-release \
    pkg-config \
    xsltproc \
    ssh \
    unzip \
    zlib1g-dev \
  && apt-get autoremove && apt-get clean && apt-get purge

RUN mkdir -p -m 0600 ~/.ssh \
  && ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN --mount=type=ssh git clone git@github.com:lizardfs/lizardfs.git /lizardfs-source

WORKDIR /lizardfs-source
RUN ./create-deb-package.sh
RUN mkdir /lizardfs-dist \
  && bash -c 'mv *.{buildinfo,changes,dsc,xz} /lizardfs-dist/' \
  && bash -c 'for i in $(ls *.deb); do name=$(echo $i | sed -E "s/\_.*//"); mkdir -p /lizardfs-dist/$name; mv $i /lizardfs-dist/$name/; done'

FROM scratch
COPY --from=build-stage /lizardfs-dist/ /
