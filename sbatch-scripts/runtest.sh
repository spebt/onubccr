#!/bin/bash

#  Try read the pymatcal path from tests/.envvars file
PYMATCAL_PATH=""
PYMATCAL_PATH="$(awk -e '$1 ~ /^PYMATCALPATH:(.*)$/ {print $2}' tests/.envvars)"

while [ -z "$PYMATCAL_PATH" ]; do
  echo "PYMATCALPATH not found in tests/.envvars"
  bash tests/init.sh
  PYMATCAL_PATH="$(grep -qsf "PYMATCALPATH:" tests/.envvars)"
done
printf "Read PYMATCALPATH: %s\n" "$PYMATCAL_PATH"
#  List all slurm files in the "tests" directory

TEST=""
echo "Choose a test to run"
select file in tests/*.slurm; do
  TEST=$file
  break
done
read -p "Submit $TEST job to the cluster? [Yy]" -n 1 -r
echo # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
else
  echo "Job submission confirmed."
fi
