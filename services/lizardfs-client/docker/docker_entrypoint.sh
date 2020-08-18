#!/usr/bin/env sh
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/lizardfs-client/examples}

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

load_config mfsmount.cfg    /etc/lizardfs/mfsmount.cfg
load_config iolimits.cfg    /etc/lizardfs/iolimits.cfg

sleep 10
mkdir /mnt/lizardfs
mfsmount /mnt/lizardfs

for i in $(seq 0 999); do
  yes 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' | head -c$(($i%50+1)) > /mnt/lizardfs/dummy${i}.txt
done

exec "$@"
