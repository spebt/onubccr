#!/bin/bash

THIS_DIR="$(dirname "$(realpath "$0")")"

# Setup the variables for the environment
CONFIRM='N'
while [[ ! $CONFIRM =~ ^[Yy]$ ]]; do
  read -rp $'Enter Pymatcal package path (contains the example folder):\n' PYMATCAL_PATH
  echo $'Pymatcal path:\n'
  echo "$PYMATCAL_PATH"
  read -rep 'Confirm the path?[Yy] ' CONFIRM
done
echo "PYMATCALPATH:" "$PYMATCAL_PATH" >"$THIS_DIR"/.envvars
