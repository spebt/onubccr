#!/bin/bash -l
#
#   How long the job will run once it begins. If the job runs longer than what is
#   defined here, it will be cancelled by Slurm.
#   If you make the expected time too long, it will
#   take longer for the job to start.
#   Format: dd:hh:mm:ss

#SBATCH --time=00:30:00

#SBATCH --ntasks=16
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=16

#   Specify the real memory required per node.  Default units are megabytes.
#   Different units can be specified using the suffix  [K|M|G|T]

#   Give your job a name, so you can recognize it in the queue

#SBATCH --job-name="test-pymatcal-install"

#   Tell slurm the name of the file to write to

#SBATCH --output=test-pymatcal-install-03.out

#   Tell slurm where to send emails about this job

#SBATCH --mail-user=myemailaddress@institution.edu

#   Tell slurm the types of emails to send.
#   Options: NONE, BEGIN, END, FAIL, ALL

#SBATCH --mail-type=NONE

#   Tell Slurm which cluster, partition and qos to use to schedule this job.

#SBATCH --partition=general-compute
#SBATCH --qos=nih
#SBATCH --cluster=ub-hpc

module load intel hdf5/1.14.1 python/3.9.6-bare
export I_MPI_PMI_LIBRARY=/opt/software/slurm/lib64/libpmi.so
RUNDIR="$1"
source "$RUNDIR/.venv/bin/activate"

srun -n 16 python "$RUNDIR/examples/test_get_config.py" "$RUNDIR/examples/test_small.yml" "$SLURM_TASKID"
