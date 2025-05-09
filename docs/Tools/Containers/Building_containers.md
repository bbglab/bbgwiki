# Building containers

Containers are built from a definition file which allows the container to be built identically by anyone possessing the file.

!!! note annotate "Root privileges required to build a container"

    Note that the process of building a container requires elevated privileges

!!! note annotate "One primary task per container"

    HPC containers are designed to perform one primary task, and should consist of a main application and its dependencies, in a similar way to how module files are provided. Since containers are lightweight, you can use separate containers instead of general purpose containers containing a collection of applications. This improves supportability, performance and reproducibility.


## How to build a container

Docker and Singularity have different standard formats for building containers and writing the definition file. However since  Singularity 4 onwards these technology can use Dockerfile as a recipe so it would be nice to use this as a standard way of writing the container recipes.


## Comfortable ways of building containers

* https://seqera.io/containers/

With this absolutely amazing resource you can specify what type of container you want to create (at the moment either Docker or Singularity) and what packages you want to include in the container. With these specifications, the website generates a container image meeting the specifications.

## Where to host/share your containers
* If the container is only for your interest you can keep it in your user, but it would be great that you have the Dockerfile somewhere that can be traceable and reproducible so that anyone can recreate it.

* If the container is from a tool of the lab then it would be great to follow the standard and best practice procedures and share it here: [BBGLab dockerhub](https://hub.docker.com/u/bbglab). In this link you can find the containers that have been built and shared by the lab. This is in general synchronized with the Dockerfile receipes here: [GitHub bbglab/containers](https://github.com/bbglab/containers). So whenever you need to build a new container with BBGLab tools make sure that you keep this good work and add the container receipe in this GitHub repository and then ask someone with permission to push the container to the collective dockerhub account.

## Advanced details on how to build a container

These can be found in  `Singularity->Building_containers` section.


## Reference

- Ferriol Calvet
- Ferran Muiños
- Jordi Deu-Pons
