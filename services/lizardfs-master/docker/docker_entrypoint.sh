#!/usr/bin/env sh
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/lizardfs-master/examples}

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

cp /var/lib/lizardfs/metadata.mfs.empty /var/lib/lizardfs/metadata.mfs

load_config mfsmaster.cfg       /etc/lizardfs/mfsmaster.cfg
load_config mfsexports.cfg      /etc/lizardfs/mfsexports.cfg
load_config mfstopology.cfg     /etc/lizardfs/mfstopology.cfg
load_config mfsgoals.cfg        /etc/lizardfs/mfsgoals.cfg
load_config globaliolimits.cfg  /etc/lizardfs/globaliolimits.cfg

if [ -n "${PERSONALITY}" ]; then
  sed -iE "/# PERSONALITY/a PERSONALITY = ${PERSONALITY}" /etc/lizardfs/mfsmaster.cfg
fi

/usr/sbin/mfsmaster start
/usr/sbin/mfsmaster stop

exec "$@"

# cat /lib/systemd/system/lizardfs-master.service
# /usr/sbin/mfsmaster start
# /usr/sbin/mfsmaster start ; /usr/sbin/mfsmaster stop ; /usr/sbin/mfsmaster start
