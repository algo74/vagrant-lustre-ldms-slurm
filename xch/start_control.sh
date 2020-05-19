#!/bin/bash

SCRIPT_PATH=/xch

slurmctld -c
source $SCRIPT_PATH/ldms/setup.sh
source $SCRIPT_PATH/ldms/start-simple-agg.sh
echo "checking lustre"
ls /proc/fs/lustre/llite
