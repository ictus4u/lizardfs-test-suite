# LizardFS Test Suite

This project will provide a docker-based testing environment for [LizardFS](https://lizardfs.com) services.

The same Docker-compose file is used to run each different kind of LizardFS service: `master`, `cgiserv`, `chunkserver`, `metalogger`, `client`, and a `shadowmaster`. You tell the container which service to run by stating the port that was exposed.

# Getting Started

These instructions will cover usage information and for the docker container.

## Prerequisities

In order to run this container you'll need docker installed.

* [Linux](https://docs.docker.com/linux/started/)

You'll need to run the files inside of the Scripts folder:

* [Generate SSH keys](/scripts/generate_ssh_keys.sh)
* [Build base image](/scripts/build_base_image.sh)

Run the docker compose file:

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
* `LIZARD_BASE_REPOSITORY` - The base repository of Lizard
* `LIZARDFS_CHUNKSERVER_HD_COUNT` - Hard drives count for LizardFs chunk server

### Volumes

* `/test-suite/volumes/config` - A shared volume for the services.

### Useful File Locations

* `/scripts/generate_ssh_keys.sh` - Generate two ssh keys to use them to read the LizardFs code to compile it, without uploading it to the repo.
* `/scripts/build_base_image.sh` - Build the base image for the services.
  
* `/scripts` - Scripts to run before the docker-compose
* `/services` - List of services to be deployed

### Services

#### Master, Metalogger, and Chunkserver

The `master`, `metalogger`, and `chunkserver` services are configured ....

#### CGI Server

The CGI Server, by default, starts a webserver inside the container running on port `9425`. You can set the `MASTER_HOST` and `MASTER_PORT` environment variables and the container will proxy the port to that master host and port. The web UI will then, by default, connect to that internal proxy when connecting to the master. Alternatively, when accessing the web UI you can put the master host ( and port as well, if it is not `9425` ).

#### Client

You can run the container with the `client` command and it will look for and connect to the `mfsmaster` and mount the filesystem into the container at `/mnt/mfs`. You can change which path the filesystem is mounted to by passing it in after `client`. The container will also need to be run as privileged and linked to the master container.

## Deployment

The LizardFS Docker image is deployed easiest through [Docker Compose](https://docs.docker.com/compose/overview) or [Docker Swarm](https://docs.docker.com/engine/swarm/). We have provided a [docker-compose.yml](/docker-compose.yml) file that can be used to test a LizardFS cluster on a local Docker installation such as [Docker Machine](https://docs.docker.com/machine/overview/).

### Docker Compose

Docker Compose is the easiest way to deploy a test LizardFS cluster on a single machine. This is a great way to test the features of LizardFS. Because it only runs on a single machine this setup not useful in production.

This repository comes with a Docker Compose file that can be used to run a test cluster. To get started just clone this repository and run `docker-compose up` in the repository root directory.

## Built With

* Docker-compose v3.7

## Find Us

* [GitHub Lizard](https://github.com/lizardfs)
* [GitHub Lizard Test Suite](https://github.com/ictus4u/lizardfs-test-suite)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/your/repository/tags). 

## Authors

* **Walter Gómez** - *Initial work* - [Ictus](https://github.com/ictus4u)

See also the list of [contributors](https://github.com/ictus4u/lizardfs-test-suite/network/dependencies/contributors) who 
participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

* [Katharos Tech's Docker LizardFs](https://github.com/katharostech/docker_lizardfs)
* [Piotr Sarna's Docker LizardFs](https://github.com/psarna/lizardfs-docker)
* [Billie Thompson's README template](https://gist.github.com/PurpleBooth/ea518ae68a49029bae95)