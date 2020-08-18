# Modules from build-stage

```dockerfile
COPY --from=build-stage /lizardfs-modules/lizardfs-adm /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-chunkserver /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-cgi /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-cgiserv /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-client /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-client3 /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-common /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-dbg /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-lib-client /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-master /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-metalogger /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-nfs-ganesha /tmp/install/
COPY --from=build-stage /lizardfs-modules/lizardfs-uraft /tmp/install/
```

- lizardfs_3.13.0.tar.xz
- lizardfs_3.13.0_amd64.buildinfo
- lizardfs_3.13.0_amd64.changes
- lizardfs_3.13.0.dsc
