#!/usr/bin/env sh
set -eux
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/lizardfs-master/examples}

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

fix_metadata() {
	local metadata_dir="/var/lib/lizardfs"
	if [ ! -f "${metadata_dir}/metadata.mfs" ]; then
		cp /tmp/metadata.mfs.empty ${metadata_dir}/metadata.mfs
	fi
  chown -R ${lizardfs_user}:${lizardfs_user} ${metadata_dir}
	ls -lAh ${metadata_dir}
	$(which mfsmetarestore) -a || true
  rm ${metadata_dir}/metadata.mfs.lock || true
}

config_dir="/etc/lizardfs"
lizardfs_user=lizardfs
load_config mfsmaster.cfg       ${config_dir}/mfsmaster.cfg
load_config mfsexports.cfg      ${config_dir}/mfsexports.cfg
load_config mfstopology.cfg     ${config_dir}/mfstopology.cfg
load_config mfsgoals.cfg        ${config_dir}/mfsgoals.cfg
load_config globaliolimits.cfg  ${config_dir}/globaliolimits.cfg

chmod -R ug+rwX,o=rX ${config_dir}/

if [ -n "${PERSONALITY}" ]; then
  sed -iE "/# PERSONALITY/a PERSONALITY = ${PERSONALITY}" ${config_dir}/mfsmaster.cfg
fi

fix_metadata

exec "$@"
