ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE} as build-stage
ENV LC_ALL="C"
ENV TZ="UTC"

RUN set -ex ; \
    apt-get update ; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
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
    unzip \
    zlib1g-dev ; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /lizardfs-source
COPY ./vendors/lizardfs ./

RUN set -e ; \
    ./create-deb-package.sh ; \
    mkdir /lizardfs-dist ; \
    bash -c 'mv *.{buildinfo,changes,dsc,xz} /lizardfs-dist/' ; \
    bash -c 'for i in $(ls *.deb); do name=$(echo $i | sed -E "s/\_.*//"); mkdir -p /lizardfs-dist/$name; mv $i /lizardfs-dist/$name/; done'

FROM busybox
COPY --from=build-stage /lizardfs-dist/ /lizardfs-modules
VOLUME ["/lizardfs-modules"]
CMD cat
