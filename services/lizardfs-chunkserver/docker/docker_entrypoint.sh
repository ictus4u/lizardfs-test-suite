#!/usr/bin/env sh
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/lizardfs-chunkserver/examples}

load_config() {
  src_config=${1:-}
  dst_config=${2:-"/etc/lizardfs/${src_config}"}
  if [ -f "/config/${src_config}" ]; then
    cp "/config/${src_config}" "${dst_config}"
  elif [ -f "${LIZARDFS_CONFIG_SOURCE}/${src_config}" ]; then
    cp "${LIZARDFS_CONFIG_SOURCE}/${src_config}" "${dst_config}"
  fi
}

dpkg -i  /tmp/install/lizardfs-*.deb

load_config mfschunkserver.cfg    /etc/lizardfs/mfschunkserver.cfg
load_config mfshdd.cfg            /etc/lizardfs/mfshdd.cfg

if [ -n "${LIZARDFS_CHUNKSERVER_HD_COUNT}" ]; then
  for i in $(seq 1 ${LIZARDFS_CHUNKSERVER_HD_COUNT}); do
    mkdir -p /mnt/hd${i}/lizardfs_vol
    echo "/mnt/hd${i}/lizardfs_vol" >> /etc/lizardfs/mfshdd.cfg
  done
fi

exec "$@"
