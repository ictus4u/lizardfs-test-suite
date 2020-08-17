#!/usr/bin/env sh
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/lizardfs-metalogger/examples}

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

chown -R lizardfs:lizardfs /var/lib/lizardfs

load_config mfsmetalogger.cfg    /etc/lizardfs/mfsmetalogger.cfg

exec "$@"
