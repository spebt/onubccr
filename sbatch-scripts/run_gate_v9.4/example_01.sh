#!/bin/sh
#
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16G
#SBATCH --job-name="run_gate_v9.4_exmaple_01"
#SBATCH --output=run_gate_v9.4_exmaple_01.out
#SBATCH --partition=general-compute
#SBATCH --qos=general-compute
#SBATCH --cluster=ub-hpc
#SBATCH --array=1-10
#Let's start some work

# Print helloworld with the hostname of the node
echo "Hello world from general-compute node: ""$(/usr/bin/uname -n)"

# Load the required modules
module load gcc/11.2.0 geant4/11.2.1 geant4-data/11.2
export GEANT4_DATA_DIR="${EBROOTGEANT4MINDATA}"
module load gcc/11.2.0 openmpi/4.1.1 gate/9.4 geant4-data/11.2

# print the versions of the ROOT and Gate
root --version
Gate --version

# Set the output directory
OUTDIR="$YOUR_OUTPUT_DIR_PREFIX"/"$SLURM_JOB_NAME"

# Set the output ROOT file name
ROOTFNAME="$SLURM_JOB_NAME"_"$SLURM_JOB_ID".root
OUTFNAME=$OUTDIR"/"$ROOTFNAME
if [ ! -d "$OUTDIR" ]; then
  echo "Make directroy:" "$OUTDIR"
  mkdir -p "$OUTDIR"
fi

if [ ! -d "$OUTDIR" ]; then
  echo Failed making "$OUTDIR"
  exit 1
fi

MACDIR=$OUTDIR"/"$SLURM_JOB_ID
if [ ! -d "$MACDIR" ]; then
  echo "Make directroy:" "$MACDIR"
  mkdir -p "$MACDIR"
fi

cp "YOUR_MACRO_DIR"/* "$MACDIR"/
echo "OUTPUT FILE: ""$OUTFNAME"

sed -i "/\/gate\/output\/tree\/addFileName ..\/data\/SPEBT.root/c\\/gate\/output\/tree\/addFileName $OUTFNAME" "$MACDIR"/output.mac
cd "$MACDIR" || exit
cat output.mac
Gate SPEBT.mac
rm -r "$MACDIR"
#Let's finish some wo
