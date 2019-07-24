# Snakemake Cluster Tutorial

This repository is based on the Software Carpentries lesson [repository](https://hpc-carpentry.github.io/hpc-python/17-cluster/) for using [Snakemake](https://snakemake.readthedocs.io/en/stable/index.html), a Python-based workflow manager. The lesson and assorted materials have been adapted for use on a Moab/Torque (PBS)-based system but are easily transferrable by adding a system specific [cluster profile configuration](config/pbs-torque/config.yaml).

## Datasets

The analysis parses a set of books to calculate various statistics. All of the raw texts are available in the `books/` directory.

## Dependencies

All dependencies are listed in [`envs/clusterTutorial.yaml`](envs/clusterTutorial.yaml). You can install them using [`conda`](https://docs.conda.io/projects/conda/en/latest/index.html) (see below for instructions).

### Conda

If you don't already have `conda` installed, please [download Miniconda](https://docs.conda.io/en/latest/miniconda.html). Miniconda3 is a Python 3-based package manager and is essentially a stripped-down version of Anaconda so it should be much faster to install.

Because this tutorial is designed to work on a Linux-based computer cluster, please follow the below instructions to set up the conda environment (if you already have an updated version of Miniconda installed, please skip to step 3):

1. Login to your cluster environment and navigate to your home folder.
2. Download & install Miniconda for 64-bit Linux systems. When it asks if it should initialize `conda`, say `yes`:
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
3. Open your cluster `.bashrc` in a text editor and edit the initialization script added by Miniconda so it resembles the following. This will allow environments to be properly inherited when passing jobs to cluster nodes for execution:
```
nano ~/.bashrc
```
```
# Adding conda to the path without initializing the base environment
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/wlclose/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
    if [ -f "/home/wlclose/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/wlclose/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/wlclose/miniconda3/bin:$PATH"
    fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
```
4. Source your `.bash_profile` to make all of the changes take effect and finish installing Miniconda (this should also re-source your `~/.bashrc`):
```
source ~/.bash_profile
```
5. Clone this repository and move into the main project folder:
```
git clone https://github.com/SchlossLab/snakemake_cluster_tutorial.git
cd snakemake_cluster_tutorial
```
6. Create an environment called `clusterTutorial` with the dependencies we need:
```
conda env create -f envs/clusterTutorial.yaml
```
7. Activate the environment before running any code:
```
conda activate clusterTutorial
```
8. Before running any jobs on the cluster, don't forget to change the `ACCOUNT` and `EMAIL` fields in the [cluster profile configuration](config/cluster.json) and the [cluster submission script](code/clusterSnakemake.pbs).

See the [`conda` documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html) for more information.
