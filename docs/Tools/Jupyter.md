# Jupyter - notebook - lab

Jupyterlab is an interactive notebook environment to run Python, R and many more languages.
jupyter.org



## Installation
Jupyter can be installed using either `conda` or `mamba` 
conda: `conda install -c anaconda jupyter`
mamba: `mamba install -c anaconda jupyter`

## Launching jupyter notebook or lab

#### locally:
Launch a new notebook session using :
```bash
jupyter notebook
``` 
or a jupyter lab session: 
```bash
jupyter lab
```
#### cluster
See [here](https://bbglab.github.io/bbgwiki/Cluster_basics/Notebooks_in_cluster/) for the instructions to launch and connect to jupyter sessions on the computing cluster

### Change conda environment from inside a running cluster session

```bash
conda install -c anaconda ipykernel
python -m ipykernel install --user --name=env_name
```
