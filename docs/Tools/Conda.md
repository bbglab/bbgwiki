# Conda and mamba

## Description

Conda and mamba are open source **package manager** and **environment management** systems for Python and other languages. They run on Windows, macOS, Linux and z/OS. These tools automate the process of installing, updating, configuring and removing software packages. They manage dependencies, ensuring that all required libraries and components are correctly installed and compatible. In our case, using package managers is specially useful because:
- They provide a way to ensure **reproducibility** in our code
- They allow a project's software tools to be **portable**
- They allow user-level installation (*i.e.* **do not require sudo** permissions)

The difference between the two is that **mamba** is a fast, drop-in replacement for conda that highly improves package resolution speed and efficiency (and we recommend you use it instead of conda to make your life happier :)). 

!!! info The majority of the commands shown below are also supported by mamba
## Installation
### Conda

Conda has two possible installers:
- Anaconda: already comes with installed packages for data science and Anaconda Navigator (GUI application). Follow the instructions.
- **Miniconda** (recommended): minimal installer provided by Anaconda  

Download any of the two installers and in your terminal run:

```bash
bash <conda-installer-name>-latest-Linux-x86_64.sh>
```

Detailed instructions [here](https://docs.conda.io/projects/conda/en/stable/user-guide/install/linux.html#installing-on-linux). 
To update conda, run:
```bash
conda update conda
```

### Mamba

The installer for mamba is **micromamba**. To install it run:
```bash
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
```
To update mamba:
```bash
micromamba self-update
```        

## Get started
```bash
conda create -n <env name> <package[=<version>]>
conda activate <env name>
conda install <package[=version]>
```

---

## Cheatsheet


### Environments

**Activate** an environment:

```bash
conda activate <environment name>
```

**Deactivates** an environment. If in `base`, closes conda.

```bash
conda deactivate
```

**List** all environments:

```bash
conda env list
```

```bash
conda info --envs
```

**Create** a new virtual environment with <packages>

```bash
conda create --name <environment name> [<packages[=<version>]>]
```

**Export** active environment to a file

```bash
conda env export > environment.yml
```

**Export all environments** to its own file:

```bash
for env in $(conda env list | cut -d" " -f1); do 
   if [[ ${env:0:1} == "#" ]] ; then continue; fi;
   conda env export -n $env > ${env}.yml
done
```

Create environment **from file**

```bash
conda env create -f environment.yml
```

**Clone** an environment

```bash
conda create --name <environment name> --clone <original environment>
```

**Remove** an environment

```bash
conda env remove --name <environment name>
```

```bash
conda remove --name <environment name> --all
```

**List all packages** installed (in current environment)

```bash
conda list
```

List all packages installed **with path**

```bash
conda list --explicit
```

Show **history of changes** in packages

```bash
conda list --revisions
```

---

### Packages

**Install** a package (_use `-f` to force the installation_)

```bash
conda install <package>
```

Install package(s) specified in a **file** (like a Python **requirements** file)

```bash
conda install --file <file>
```

**Uninstall** a package

```bash
conda remove <package>
```

**Search** for a package

```bash
conda search <package>
```

---

### Configuration

**Show** configuration

```bash
conda config --show
```

**Add channels** (use `add` instead of `append` to put the channel on the top of the list)

```bash
conda config --append channels <channel name>
```

---

### Building Packages

**Install** conda build

```bash
conda install conda-build
```

**Build** package

```bash
conda build <directory with the files>
```

Build for **other platforms**

```bash
conda convert --platform all <path to package>
```

**Install built** package

```bash
conda install --use-local <package>
```

---

### From Pypi

**Create** files

```bash
conda skeleton pypi <package>
```

Build for **different Python version**

```bash
conda build --python <version> <directory with the files>
```

---

### Custom Channel

**Add** channel

```bash
conda config --append channels file://<path to folder>
```

**(re)build** the index

```bash
conda index <channel folder>/<platform>
```

## Reference

- Jordi Deu Pons
- Miguel Grau
- Federica Brando
- Carlos López-Elorduy
- Raquel Blanco
