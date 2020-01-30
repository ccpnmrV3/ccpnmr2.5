#!/usr/bin/env bash
# Compile C Code for te current environment, should be executed from the end of installMiniconda
# ejb 19/9/17
#
# Remember to check out the required release in Pycharm, or manually with git in each repository.
#
# recompile the c code in the src/c directory
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# import settings
source ./common.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# start of code

detect_os
if [[ "$MACHINE" == *"UNKNOWN"* ]]; then
  echo "machine not in [${OS_LIST[*]}]"
  continue_prompt "do you want to try an OS from the list?"
  show_choices
  read_choice ${#OS_LIST[@]} " select an OS from the list > "
fi
if [[ ${MACHINE} == *"MacOS"* ]]; then
  # required for getting the correct path from miniconda website
  MACOSAPPEND='X'
fi

BIT_COUNT="$(uname -m)"
echo "current machine: ${MACHINE}, ${BIT_COUNT}"

# check whether using a Mac

check_darwin

# copy the correct environment file

echo "compiling C Code"
cd "${CCPNMR_TOP_DIR}/ccpnmr2.4/c" || exit

echo "using environment_${MACHINE}.txt"
if [[ ! -f environment_${MACHINE}.txt ]]; then
  echo "environment doesn't exists with this name, please copy closest and re-run compileCCode"
  exit
fi

# run 'make'

echo "setting up environment file"
# CONDA_PATH="PYTHON_DIR = $(which python | rev | cut -d'/' -f3- | rev)"
CONDA_PATH="PYTHON_DIR = ${ANACONDA3}"
cp "environment_${MACHINE}.txt" environment.txt
error_check
sed -i.bak "1 s|^.*$|${CONDA_PATH}|" environment.txt && rm -rf environment.txt.bak

echo "making"
#make -B $*