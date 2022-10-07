# Building containers

Singularity containers are built from a definition file which allows the container to be built identically by anyone possessing the file.

!!! note annotate "Root privileges required to build a container"

    Note that the process of building a container requires elevated privileges

!!! note annotate "One primary task per container"

    HPC containers are designed to perform one primary task, and should consist of a main application and its dependencies, in a similar way to how module files are provided. Since containers are lightweight, you can use separate containers instead of general purpose containers containing a collection of applications. This improves supportability, performance and reproducibility.

## Building a Singularity container from scratch

Building from scratch gives complete control over the contents of the container, including operating system and packages. Certain packages may only be available for a specific version of Linux (i.e. compatibility issues) so being able to build a container from scratch enhances research capability.

The following example demonstrates building an Ubuntu 20 (focal) container using definition file `ubuntu20_helloworld.def` that installs the `python3` package via the Ubuntu package manager:

```text
BootStrap: debootstrap
OSVersion: focal
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%post
  apt-get install --yes python3

%runscript
  python3 "${@}"
```

The build process is unattended, and will not succeed if any operations require interactive input. Be sure to use `-y` or `--yes` options when installing packages.

Create the image (this step requires root privileges):

```bash
sudo singularity build ubuntu20_helloworld.simg ubuntu20_helloworld.def
```

This will result in a usable image in the current working directory. Be aware that if you want a very specific version of package from a repository, that package may not be available in future, so where possible, try to future-proof your containers.

### Building containers for other Linux distributions

You may build Ubuntu images using CentOS and vice versa. However to bootstrap, you will need extra packages on the host OS to build the container. CentOS hosts require the `debootstrap` package to create Ubuntu containers, and Ubuntu hosts require the `yum` package to build CentOS containers. Alternatively you may create containers from an existing Singularity or Docker image, as explained in the following section. Since this method builds upon pre-built images, the `debootstrap` or `yum` packages are not required.

!!! note annotate "Using LTS for Ubuntu definitions"

    When building an Ubuntu container we recommend that you use a release with [long term support](https://www.ubuntu.com/about/release-cycle) (LTS release). Non-LTS Ubuntu releases have very limited support cycles which may lead to difficulties downloading packages if used after their end-of-life date.

## Building containers from an existing base image

This enables you to either build or use an existing container as a base image to build other containers. Base images must be built first if part of a dependency chain and is no longer required once all dependent containers have been built.

### Singularity local images

The following example demonstrates the creation of a local base Ubuntu 20 (focal) image using definition file `ubuntu20_base.def`, and then creating another container with `python3` installed, using the local base image:

```text
BootStrap: debootstrap
OSVersion: focal
MirrorURL: http://us.archive.ubuntu.com/ubuntu/
```

Create the base image:

```bash
sudo singularity build ubuntu20_base.simg ubuntu20_base.def
```

The non-base image container (i.e. `python3` in this example) can be built using definition file `ubuntu20_python3.def`:

```text
Bootstrap: localimage
From: ubuntu20_base.simg

%post
  apt-get install --yes python3

%runscript
  python3 "${@}"
```

The result will be a container almost identical to the one created from scratch.

```bash
sudo singularity build ubuntu20_python3.simg ubuntu20_python3.def
```

### Docker images

You can also bootstrap from Docker containers, although if supplied by a third party, you have less visibility or control over these images, so use with caution, as this may impact the future reproducibility of results.

The below example demonstrates installing the `python3` package within an Ubuntu 20 (focal) container using definition file `ubuntu20_docker_python3.def`, which imports the `ubuntu:20.04` base container available on the Docker Hub:

```text
Bootstrap: docker
From: ubuntu:20.04

%post
  apt-get update
  apt-get install --yes python3

%runscript
  python3 "${@}"
```

Build the container. This will produce a container similar to the previous examples, but may vary slightly in overall size depending on packages installed in the base docker image:

```bash
sudo singularity build ubuntu20_docker_python3.simg ubuntu20_docker_python3.def
```

## Future-proofing your containers

When building your own containers, be sure to make them portable and future-proof.

- Consider whether the container will still build and produce the same results if the OS release or application version changes.
- If copying files from a working directory as part of setup is unavoidable, ensure that any files copied from the working directory are are available for others to download (i.e. in a git repository if not large).
- Perform all setup as part of the build process. If any manual steps are performed after the container is built, they should be integrated within the definition file, and the container rebuilt.
- Consider if the ability to rebuild your container will be impacted by package updates, or deprecation of old releases.

!!! note annotate "Legacy versions of CentOS applications"
    Outdated minor CentOS releases are moved from the main CentOS servers to vault.centos.org. If you need to use a specific Operating System or application version other than the latest, you need to future-proof your container by using the CentOS vault.

## Definition file sections

The following example definition file demonstrates commonly used definition file sections:

- `%help`
- `%post`
- `%environment`
- `%test`
- `%runscript`

### Help section

The `%help` section is designed to provide information about the container when singularity run-help is run on the container, for example:

```bash
$ singularity run-help /data/containers/public/python3_helloworld.simg
Purpose: Test container to print "Hello, World!" in Python3.
Author:  ITS Research / QMUL.
```

### Post section

The `%post` section contains the commands used to build the container, such as package installs, file downloads, compilation and software configuration.

### Environment section

Environment settings supplied at build-time in the `%post` section are only set during build-time and are not available at run-time. Environment settings which need to be available at run-time should be added to the `%environment` section.

### Test section

The `%test` section defines a set of commands or tests which should be run to validate the container has been built successfully. Some example tests include:

- installed binaries are available on the `PATH` variable
- `--help` or `--version` parameter for binaries (if supported)
- libraries, header files and man pages exist

All tests will be run during the build process, after `%post` has completed. To build a container without running the tests, pass the `-T` or `--notest` option to the singularity build command.

To run the tests for an existing container, run the singularity test command, for example:

```
$ singularity test /data/containers/public/python3_helloworld.simg
/usr/bin/python3
```

### Runscript section

The `%runscript` section defines the default action a container will perform when ran as an executable or with `singularity run`. This is configured during the build process.

!!! note annotate "Application parameters or arguments"

    If the runscript calls an application which takes parameters or arguments, include "${@}" after the application otherwise anything passed after the container name will be ignored by Singularity.

### Inspecting a container

To display information about how a container was build, use the `singularity inspect` command. The `-d` option to this command will print the definition file used to built the container and the `-r` option will print the runscript (if added during build-time). For example:

```bash
$ singularity inspect -d /data/containers/public/python3_helloworld.simg
Bootstrap: docker
From: ubuntu:20.04

%help
  Purpose: Test container to print "Hello, World!" in Python3.
  Author:  ITS Research / QMUL.

%post
  apt-get update
  apt-get install --yes python3

  apt-get clean && \
   rm -rf /var/lib/apt/lists/*

%test
  which python3

%runscript
  python3 -c 'print("Hello, World!")'
```

The `singularity help inspect` command provides additional options for inspecting the container.

## Reference

- Jordi Deu-Pons
- Miguel Grau
- Carlos López Elorduy
