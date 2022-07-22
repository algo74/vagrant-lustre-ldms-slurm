#!/bin/bash

SCRIPT_PATH=/xch/scripts

# Start Slurm
slurmctld -c

# Start LDMS
source $SCRIPT_PATH/ldms/setup.sh
sh $SCRIPT_PATH/ldms/start-simple-agg.sh
# sh $SCRIPT_PATH/check_lustre.sh
