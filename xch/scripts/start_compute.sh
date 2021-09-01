#!/bin/bash

SCRIPT_PATH=/xch/scripts

# init file for jobinfo
$SCRIPT_PATH/slurm/jobid_stop.sh

# start Slurm
slurmd -c

# start LDMS
source $SCRIPT_PATH/ldms/setup.sh
sh $SCRIPT_PATH/ldms/start-simple-sampler.sh
sh $SCRIPT_PATH/check_lustre.sh
