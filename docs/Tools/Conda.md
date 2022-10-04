# Docker

## Description
Conda is an open source package management system and environment management system that runs on Windows, macOS, Linux and z/OS. Conda quickly installs, runs and updates packages and their dependencies. 


## Get started 
```bash
conda create -n <env name> <package[=<version>]>
conda activate <env name>
conda install <package[=version]>
```

## Cheatsheet

#### Environments

Activate an environment
$ conda activate <environment name>
Use *base* for no environment
Deactivate and environment
Goes to base
$ conda deactivate
List all environments
$ conda env list
$ conda info --envs
Create a new virtual environment with <packages>
anaconda and conda can be used as package
$ conda create --name <environment name> [<packages[=<version>]>]
Export active environment to a file
$ conda env export > environment.yml
Create environment from file
$ conda env create -f environment.yml
Clone an environment
$ conda create --name <environment name> --clone <original environment>
Remove an environment
$ conda env remove --name <environment name>
$ conda remove --name <environment name> --all
List all packages installed (in current environment)
$ conda list
List all packages installed with path
$ conda list --explicit
Show history of changes in packages
$ conda list --revisions
Packages
Install a package
$ conda install <package>
use -f to force the installation
Install package(s) specified in a file
like a Python requirements file
$ conda install --file <file>
Uninstall a package
$ conda remove <package>
Search for a package
$ conda search <package>
Configuration
Show configuration
$ conda config --show
Add channels
$ conda config --append channels <channel name>
use "add" instead of "append" to put the channel on the top of the list
Building Packages
Install conda build
$ conda install conda-build
Build package
$ conda build <directory with the files>
Build for other platforms
$ conda convert --platform all <path to package>
Install built package
$ conda install --use-local <package>
From Pypi
Create files
$ conda skeleton pypi <package>
Build for different Python version
$ conda build --python <version> <directory with the files>
Custom Channel
Add channel
$ conda config --append channels file://<path to folder>
(re)build the index
$ conda index <channel folder>/<platform> 




## Reference
