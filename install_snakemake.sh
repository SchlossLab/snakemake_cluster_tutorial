#!/bin/bash

# An install script to instantly deploy minconda/numpy/matplotlib/snakemake
# on a new cluster. You can uninstall the installed tools by editing ~/.bashrc

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
echo 'export PATH=~/miniconda3/bin:~/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
conda install -y matplotlib numpy graphviz
pip install --user snakemake

