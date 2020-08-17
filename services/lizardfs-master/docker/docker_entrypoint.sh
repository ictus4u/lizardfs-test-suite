#!/usr/bin/env sh
LIZARDFS_CONFIG_SOURCE=${LIZARDFS_CONFIG_SOURCE:-/usr/share/doc/lizardfs-master/examples}
dpkg -i  /tmp/install/lizardfs-*.deb

cp ${LIZARDFS_CONFIG_SOURCE}/mfsmaster.cfg /etc/lizardfs/
cp ${LIZARDFS_CONFIG_SOURCE}/mfsexports.cfg /etc/lizardfs/
cp ${LIZARDFS_CONFIG_SOURCE}/mfstopology.cfg /etc/lizardfs/
cp ${LIZARDFS_CONFIG_SOURCE}/mfsgoals.cfg /etc/lizardfs/
cp ${LIZARDFS_CONFIG_SOURCE}/globaliolimits.cfg /etc/lizardfs/
cp /var/lib/lizardfs/metadata.mfs.empty /var/lib/lizardfs/metadata.mfs
/usr/sbin/mfsmaster start
/usr/sbin/mfsmaster stop

exec "$@"

# cat /lib/systemd/system/lizardfs-master.service
# /usr/sbin/mfsmaster start
# /usr/sbin/mfsmaster start ; /usr/sbin/mfsmaster stop ; /usr/sbin/mfsmaster start
