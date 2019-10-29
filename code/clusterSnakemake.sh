#!/bin/bash

###############################
#                             #
#  1) Job Submission Options  #
#                             #
###############################

# Name
#SBATCH --job-name=clusterSnakemake

# Resources
# For MPI, increase ntasks-per-node
# For multithreading, increase cpus-per-task
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000mb
#SBATCH --time=45:00

# Account
#SBATCH --account=ACCOUNT
#SBATCH --partition=standard

# Logs
#SBATCH --mail-user=EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=code/log/%x-%j.out

# Environment
##SBATCH --export=ALL

# List compute nodes allocated to the job
if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi



#####################
#                   #
#  2) Job Commands  #
#                   #
#####################

# Initiating snakemake and running workflow in cluster mode
snakemake --profile config/slurm/ --latency-wait 20
