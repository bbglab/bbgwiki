# Docker

Docker **Desktop** is free for educational, personal use, research, and non-commercial use, but check the [Docker Subscription Service Agreement overview](https://www.docker.com/legal/docker-subscription-service-agreement/) in case any of this applies to your intended use.

## Licensing (Docker Engine vs Docker Desktop)

The *Docker Engine* (the runtime/daemon `dockerd` and related components) is open source and distributed under the **Apache License 2.0** (a permissive license). Docker explicitly documents this in the Docker Engine manual:

- Docker Engine licensing: https://docs.docker.com/engine/#licensing
- Docker Engine upstream license (Moby project): https://github.com/moby/moby/blob/master/LICENSE

Note: Docker Desktop is a separate product with its own subscription/license terms; Docker also notes that the licensing terms for the Docker/Moby open-source projects (such as Docker Engine) aren’t changing:

- Docker Desktop license agreement note: https://docs.docker.com/subscription/desktop-license/

## Description

* You cannot use Docker in the cluster.

* But you can use Docker to create your custom containers locally.

## Create Docker containers

Internally we have this GitHub repository with the receipes for many of the custom containers that we are generating and hosting in our dockerhub.

If you need/want to create a new container, you can follow guidelines on how is the most appropriate way of doing it, and once you have a working version of it, you must:

* Add your Dockerfile and associated files required for generating the container to our [GitHub repository of containers](https://github.com/bbglab/containers-recipes). Make sure that your container is fully reproducible.

* If appropriate ask some BBG member with permission to upload it to the lab [docker hub](https://hub.docker.com/u/bbglab).


## Reference

- Ferriol Calvet
