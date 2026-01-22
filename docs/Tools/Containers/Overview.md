<!-- # Overview -->
# Linux Containers

Linux containers are lightweight, portable execution environments that package up software and all its dependencies so
it can run reliably across different computing environments. Unlike virtual machines, containers share the host
operating system kernel while isolating the user space — meaning they can run different Linux distributions and
applications in a self-contained way, with minimal overhead.

Popular container technologies include [Docker](https://docker.com/) and
[Singularity (Apptainer)](https://apptainer.org/). Docker is widely used in software development, CI/CD pipelines, and
cloud environments, while Singularity is tailored for High Performance Computing (HPC) and multi-user systems where
security and integration with shared filesystems and hardware (e.g., GPUs) are critical.

## Benefits of Containers

- **Reproducible science** – Containers encapsulate software and dependencies, ensuring consistency
across different systems and over time.
- **Version independence** – Run software compiled for one Linux distribution (e.g., Ubuntu) on another
(e.g., CentOS), without modification.
- **Portability** – Containers can be built once and deployed anywhere a compatible container runtime is available.
- **Self-contained environments** – Avoid conflicts with system-installed software and simplify the setup of
complex applications.

## Comparing Docker and Singularity

| Feature                     | Docker                                | Singularity (Apptainer)              |
|----------------------------|----------------------------------------|--------------------------------------|
| Root access needed         | Yes (typically requires root/daemon)   | No (designed for unprivileged users) |
| HPC compatibility          | Limited                                | Excellent (built for HPC)            |
| Uses Docker images         | Yes                                    | Yes                                  |
| GPU/Infiniband support     | With additional configuration          | Native support                       |
| Suitable for shared clusters | Rarely                                | Yes                                  |
| Security model             | Daemon-based, less suitable for multi-user systems | User-space execution with no privilege escalation |

## Singularity

<img alt="singulairity logo" src="../../assets/images/singularity_logo.png"  width="100" height="100">

[Singularity](https://sylabs.io/guides/latest/user-guide/introduction.html) (also known as Apptainer in newer releases)
is a secure, Open Source container platform designed for HPC environments. Compared to Docker,
Singularity offers several advantages for scientific computing:

- Runs without requiring root privileges, enhancing security in shared environments.
- Supports integration with high-performance hardware such as GPUs and Infiniband networks.
- Can directly use Docker container images, allowing users to leverage the extensive Docker ecosystem while benefiting
from Singularity’s HPC compatibility.

## Using containers in the cluster

!!! warning
    Singularity is the only container technology that works in HPC systems, thus in our cluster
    we can only use Singularity

Even if a container was built using Docker, and/or it is hosted in [dockerhub](https://hub.docker.com) you can still use
it from Singularity.

For more information on how to use it check the `Using_containers` section in the Singularity folder.

## Container sources

There are different places where you can find containers that are ready to use:

- Our cluster: `/data/bbg/datasets/pipelines/nextflow_containers` here there are several containers that are used by
different people in the lab, mainly for running Nextflow pipelines.

- [BBGLab dockerhub](https://hub.docker.com/u/bbglab) here you can find the containers that have been built and shared
by the lab. This is in general synchronized with the Dockerfile recipes here:
[GitHub bbglab/containers](https://github.com/bbglab/containers). So whenever you need to build a new container with
BBGLab tools make sure that you keep this good work and add the container recipe in this GitHub repository and then ask
someone with permission to push the container to the collective dockerhub account.

- [dockerhub](https://hub.docker.com) this is a public repository of containers where you can push your own containers
and also use other people's containers.

## Further Reading

- [Singularity website](https://sylabs.io/guides/latest/user-guide/index.html)
- [Docker website](https://www.docker.com/resources/what-container)
- [BBGcloud presentation on Singularity](https://docs.google.com/presentation/d/1D4ExctFpb2kiSGMQ5rOQ4ctw6lktloey1Ak6xD9ZQ38/edit#slide=id.p) <!--markdownlint-disable MD013-->
- [BBGcloud presentation on Linux and containers](https://docs.google.com/presentation/d/1FRRg5Rml8sIPgm6KLEIK-Avr7vAyE_0yIRVUFug0U3s/edit#slide=id.p) <!--markdownlint-disable MD013-->
- Use `singularity help` and `singularity CMD help` (replace `CMD` with a Singularity command, such as `run`)  
- View the system manual page: `man singularity`

## Reference

- Reorganized and updated by Ferriol Calvet

Previous explanation by:

- Jordi Deu-Pons
- Miguel Grau
- Axel Rosendahl Huber
- Carlos López-Elorduy
