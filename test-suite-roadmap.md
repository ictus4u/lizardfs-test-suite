# LizardFS Test-suite roadmap

## Tasks

### Create a git project for lizardfs-test-suite

- [ ] Proposed structure:

```yml
root:
  - README.md
  - scripts:
    - build_base_image.ssh
    - generate_ssh_keys.ssh
  - services:
    - lizardfs-base:             # Here the lizardfs is built from source and packaged
      - Dockerfile
      - docker:
        - ssh:                   # Authentication credentials for pulling from github (probably not commited)
          - id_ed25519
          - id_ed25519.pub
          - config
    - lizardfs-master:
      - Dockerfile
      - docker:
        - docker_entrypoint.sh
    - lizardfs-cgiserv:
      - Dockerfile
      - docker:
        - docker_entrypoint.sh
    - lizardfs-chunkserver:
      - Dockerfile
      - docker:
        - docker_entrypoint.sh
    - lizardfs-metalogger:
      - Dockerfile
      - docker:
        - docker_entrypoint.sh
    - lizardfs-client:
      - Dockerfile
      - docker:
        - docker_entrypoint.sh
  - test-suite:
    - suite1:
      - docker-compose.yml
      - README.md
      - volumes:
        - config:                # docker_entrypoint.sh needs to take care about config files processing
          - globaliolimits.cfg
          - mfsexports.cfg
          - mfshdd.cfg           # The mount will be simulated to a /mnt/hd1/lizardfs_vol with number of disks set by environment variable
          - mfstopology.cfg
          - mfschunkserver.cfg
          - mfsgoals.cfg
          - mfsmaster.cfg
```

### docker (per each service)

- [ ] Set environment variables to be used, eg LIZARDFS_CHUNKSERVER_HD_COUNT
- [ ] Set entrypoint script
  - Run original entrypoint
  - [ ] Setup service configuration
    - copy/update files from sources to the target dir
    - manage environment variables interpolaiton
  - Run service
- [ ] (Optional) Find a way for keeping the image lean
  - Install without copying the .deb for avoiding to have it in a layer?

### docker-compose

- [ ] Orchestrate the test suite
  - Create a docker-compose.yml per test-suite (first one so far)
  - Name the services as indicated to be in /etc/hosts configuration, take adventage of docker-compose networking management (perhaps no /etc/hosts configuration needed?)
    - If /etc/hosts is still needed (chunserver1, chunserver2...), then we need to find a way to figureout the docker containers assigned local ips (docker inspect?)
  - Volume mount the configuration folder to be used by the entrypoint script
  - Publish master and cgiserv ports (be careful about port colission)

### Jenkins

- [ ] Create a pipeline (set it up to run manual?)
  - Jenkinsfile per project vs per test-suite. What to do?
- [ ] Setup jenkins agent to include ssh support ?
- [ ] Define a deployment target (required to have docker-compose)
- [ ] Pull project code and push to the target
- [ ] SSH restart docker-compose

### Documentation

- [ ] Write the general README.md file

### Final test

- [ ] Set LizardfsRESTfulAPI to point to this test-suite
- [ ] Do the same in Jenkins pipeline
