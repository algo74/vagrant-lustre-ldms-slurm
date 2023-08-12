#!/bin/bash

SCRIPT_PATH=/xch/scripts

# Start Slurm
LOG_FILE="/xch/logs/slurm/SlurmctldLogFile.$(date +%F.%H%M%S)"
slurmctld -c -L $LOG_FILE

# Start LDMS
source $SCRIPT_PATH/ldms/setup.sh
sh $SCRIPT_PATH/ldms/start-simple-agg.sh
# sh $SCRIPT_PATH/check_lustre.sh

# prepare directories needed by workload jobs
sudo mkdir -p /lustre/all
sudo chmod 777 /lustre/all