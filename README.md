# Snakemake Cluster Tutorial

This repository is based on the Software Carpentries lesson [repository](https://hpc-carpentry.github.io/hpc-python/17-cluster/) for using [Snakemake](https://snakemake.readthedocs.io/en/stable/index.html), a Python-based workflow manager. The lesson and assorted materials have been adapted for use on a Moab/Torque (PBS)-based system but are easily transferrable by adding a system specific [cluster profile configuration](config/pbs-torque/config.yaml).

## Datasets

The analysis parses a set of books to calculate various statistics. All of the raw texts are available in the `books/` directory.

## Dependencies

All dependencies are listed in [`envs/clusterTutorial.yaml`](envs/clusterTutorial.yaml). You can install them using [`conda`](https://docs.conda.io/projects/conda/en/latest/index.html) (see below for instructions).

### Conda

If you don't already have `conda` installed, please [download Miniconda](https://docs.conda.io/en/latest/miniconda.html). Miniconda3 is a Python 3-based package manager and is essentially a stripped-down version of Anaconda so it should be much faster to install.

Because this tutorial is designed to work on a Linux-based computer cluster, please follow the below instructions to set up the conda environment (if you already have an updated version of Miniconda installed, please skip to step 3):
1. Login to your cluster environment and navigate to your home folder
2. Download & install Miniconda for 64-bit Linux systems:
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
3. Clone this repository and move into the main project folder:
```
git clone https://github.com/SchlossLab/snakemake_cluster_tutorial.git
cd snakemake_cluster_tutorial
```
4. Create an environment called `clusterTutorial` with the dependencies we need:
```
conda env create -f envs/clusterTutorial.yaml
```
5. Activate the environment before running any code:
```
conda activate clusterTutorial
```
6. Before running any jobs on the cluster, don't forget to change the `ACCOUNT` and `EMAIL` fields in the [cluster profile configuration](config/pbs-torque/config.yaml).

See the [`conda` documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html) for more information.
