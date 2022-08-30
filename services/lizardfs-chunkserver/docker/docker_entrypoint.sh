#!/usr/bin/env sh
set -eux
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/mfs-chunkserver/examples}


load_config() {
  src_config=${1:-}
  dst_config=${2:-"${config_dir}/${src_config}"}
  if [ -f "/config/${src_config}" ]; then
    cp "/config/${src_config}" "${dst_config}"
  elif [ -f "${LIZARDFS_CONFIG_SOURCE}/${src_config}" ]; then
    cp "${LIZARDFS_CONFIG_SOURCE}/${src_config}" "${dst_config}"
	elif [ -f "${config_dir}/${src_config}.dist" ]; then
		cp "${config_dir}/${src_config}.dist" "${dst_config}"
  elif [ -f "/tmp/${src_config}.dist" ]; then
		cp "/tmp/${src_config}.dist" "${dst_config}"
  fi
}

config_dir=/etc/mfs
lizardfs_user=mfs

load_config mfschunkserver.cfg    ${config_dir}/mfschunkserver.cfg
load_config mfshdd.cfg            ${config_dir}/mfshdd.cfg

if [ ! -f ${config_dir}/mfschunkserver.cfg ]; then
	cp ${config_dir}/mfschunkserver.cfg.dist ${config_dir}/mfschunkserver.cfg
fi

if [ -n "${LIZARDFS_CHUNKSERVER_HD_COUNT}" ]; then
  for i in $(seq 1 ${LIZARDFS_CHUNKSERVER_HD_COUNT}); do
		hdd_path=/hdd/hd${i}/lizardfs_vol
    mkdir -p "${hdd_path}"
    echo "${hdd_path}" >> ${config_dir}/mfshdd.cfg
    chown -R ${lizardfs_user}:${lizardfs_user} "${hdd_path}"
  done
fi

chmod -R ug+rwX,o=rX ${config_dir}

data_path="/var/lib/mfs/"
chown ${lizardfs_user}:${lizardfs_user} -R ${data_path}
exec "$@"
