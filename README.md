# LizardFS Test Suite

This project provides a docker-based testing environment for [LizardFS](https://lizardfs.com) services.

`docker-compose` is used for the orchestration of different kind of LizardFS services: `master`, `cgiserv`, `chunkserver`, `metalogger`, `client`, and a `shadowmaster`.

## Getting Started

The project is structured in 3 folders:
* _scripts_: Contains utility scripts for preparing the project to run.
* _services_: Has the configuration for building the Docker images for the services, mainly a Dockerfile per each service and an entrypoint script for taking care of runtime settings.
* _test-suite_: Contains a first `lfs-test-suite1` configuration. It's described by a [docker-compose.yml](test-suite/lfs-test-suite1/docker-compose.yml) file.

The services folder has two special images:

* _lizarfs-dist_ is where the LizardFS modules are built from the source code of their [official repository](https://github.com/lizardfs/lizardfs)
* _lizardfs-base_ is an ubuntu based image on top of which the rest of the LizardFS service images are built.

## Prerequisities

In order to run this container you'll need docker and docker-compose installed.

* [Docker - Linux](https://docs.docker.com/linux/started/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. Clone this repository.
2. Use the `/scripts/build_base_image.sh` script. It's for easing the process of base image creation.
3. Customize the docker images if needed.
4. Customize the test suite for your needs.
5. Run the docker compose file: `docker-compose up -d`

**docker-compose.yml**
```yaml
x-master:
  &lfs-master
  <<: *default-common
  image: lizardfs-master:latest
  build:
    context: ../../services/lizardfs-master
  expose:
    # metaloggers module
    - "9419"
    # chunkservers module
    - "9420"
    # tapeservers module
    - "9424"
    # main master server module
    - "9421"
...
```

## Usage

### Environment Variables

* `ENVIRONMENT_FILE` - The environment file
* `LIZARD_BASE_REPOSITORY` - The LizardFS base repository
* `LIZARDFS_CHUNKSERVER_HD_COUNT` - Hard drives count for LizardFs chunk servers

### Volumes

* `/test-suite/volumes/config` - A shared volume for the services.

### Useful File Locations

* `/scripts/build_base_image.sh` - Builds the base image for the services.
* `/scripts` - Scripts to run before the docker-compose.
* `/services` - List of services to be deployed.

### Services

#### Master, Metalogger, and Chunkserver

The `master`, `metalogger`, and `chunkserver` services are configured ....

#### CGI Server

The CGI Server, by default, starts a webserver inside the container running on port `9425`. You can set the `MASTER_HOST` and `MASTER_PORT` environment variables and the container will proxy the port to that master host and port. The web UI will then, by default, connect to that internal proxy when connecting to the master. Alternatively, when accessing the web UI you can put the master host ( and port as well, if it is not `9425` ).

#### Client

You can run the container with the `client` command and it will look for and connect to the `mfsmaster` and mount the filesystem into the container at `/mnt/mfs`. You can change which path the filesystem is mounted to by passing it in after `client`. The container will also need to be run as privileged and linked to the master container.

## Deployment pipeline

A [Jenkinsfile](Jenkinsfile) was added in order to automatize the build and deployment process. 

### Docker Compose

Docker Compose is a way to deploy a test LizardFS cluster on a single machine. This is a great way to test the features of LizardFS. Because it only runs on a single machine, this setup is not useful in production environment.

This repository comes with a Docker Compose file that can be used to run a test cluster. To get started just clone this repository and run `docker-compose up` in the repository root directory.

## Built With

* docker-compose v3.7

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Walter Gómez** - *Initial work* - [Ictus](https://github.com/ictus4u)

See also the list of [contributors](/docs/contributors) who 
participated in this project.

## License

This project is unlicensed.
