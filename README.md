# LizardFS Test Suite

This project will provide a docker-based testing environment for [LizardFS](https://lizardfs.com) services.

The same Docker-compose file is used to run each different kind of LizardFS service: `master`, `cgiserv`, `chunkserver`, `metalogger`, `client`, and a `shadowmaster`. You tell the container which service to run by stating the port that was exposed.

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

# Getting Started

These instructions will cover usage information and for the docker container.

## Prerequisities

In order to run this container you'll need docker installed.

* [Linux](https://docs.docker.com/linux/started/)

## Usage

### Container Parameters

List the different parameters available to the container

```shell
docker run give.example.org/of/your/container:vx.x.x parameters
```

### Environment Variables

* `VARIABLE_ONE` - A Description
* `ANOTHER_VAR` - More Description
* `YOU_GET_THE_IDEA` - And another

### Volumes

* `/your/file/location` - File location

### Useful File Locations

* `/some/special/script.sh` - List special scripts
  
* `/magic/dir` - And also directories

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

```bash
$ cd lizardfs-test-suite
$ docker-compose up -d --scale mfsmaster-shadow=2 --scale chunkserver=3 --scale metalogger=4
```

You can then hit the web interface on `8080` at the IP address of the server running Docker. On the "Servers" tab of the web interface you should be able to see that you have a cluster consisting of X master, X shadow masters, X chunkservers, and X metaloggers. Congratulations, you are running a full LizardFS cluster!

You can experiment with the cluster by creating some files. Exec into one of the client containers and copy `/etc` inside the container to the LizardFS mountpoint at `/mnt/mfs`.

```bash
$ docker-compose exec client1 bash
root@containerid:/$ cd /mnt/mfs
root@containerid:/mnt/mfs$ cp -R /etc .
```

The web UI will show that you now have XX chunks in your cluster.

![web-ui-screenshot](/web-ui-screenshot.png)

`exec`ing into the other client container will prove that you successfully mounted your LizardFS filesystem on two clients at the same time.

```bash
$ docker-compose exec client2 bash
root@containerid:/$ cd /mnt/mfs
root@containerid:/mnt/mfs$ ls
etc
```

## Built With

* List the software v0.1.3
* And the version numbers v2.0.0
* That are in this container v0.3.2

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