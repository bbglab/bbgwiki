<!-- # Overview -->
# Singularity containers

Linux containers are self-contained execution environments that share a Linux kernel with the host, but have isolated resources for CPU, I/O, memory, etc. A container can run a completely different Linux environment, without the overhead required by virtual machines.

## Benefits of containers

- Reproducible science - containers can include an application and its dependencies, and be run on other systems where Singularity is installed.
- Version independent - run code designed for other versions of Linux e.g. Ubuntu packages on a CentOS system.
- Self-contained - allow isolation of complicated application installs.

## Singularity

<img src="/assets/images/singularity_logo.png"  width="100" height="100">

[Singularity](https://sylabs.io/guides/latest/user-guide/introduction.html) is a popular Open Source container solution designed for HPC. Unlike other container solutions such as [Docker](https://docker.com/), it allows utilisation of GPUs and Infiniband interconnects for MPI jobs, and does not allow privilege escalation within a container, which would compromise the security in a multi-user environment with a shared filesystem.

## Using Singularity on the bbgcluster

Singularity is available as a system package on the bbgcluster. We may update the version of Singularity installed on the cluster to address security vulnerabilities or to provide extra features as they become available. Recently, the default version of Singularity has been changed to **singularity v3**, although Singularity v2 can still be used with the command `singularity2`.

## Resources

Containers built by ITS Research are stored in `/data/containers` and are supported in a similar way to the globally available supported applications. Applications installed within Singularity containers may also be provided as a module to abstract the container invocation commands. See the Singularity usage page for more information about containers provided as modules.

## Further reading

- [Singularity website](https://sylabs.io/guides/latest/user-guide/index.html)
- Running `singularity help` and `singularity CMD help` (replace `CMD` with a Singularity command, such as `run`)
- Viewing the "singularity" manual page

## Reference

- Jordi Deu-Pons
- Miguel Grau
- Carlos López-Elorduy
