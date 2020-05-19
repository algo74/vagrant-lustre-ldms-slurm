#!/bin/bash

SCRIPT_PATH=/xch

# init file for jobinfo
$SCRIPT_PATH/slurm/jobid_stop.sh

slurmd -c
source $SCRIPT_PATH/ldms/setup.sh
source $SCRIPT_PATH/ldms/start-simple-sampler.sh
echo "checking lustre"
ls /proc/fs/lustre/llite
