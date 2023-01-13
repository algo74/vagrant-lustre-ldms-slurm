#!/bin/bash

LOGFILE=/xch/logs/slurm/run_sevi_log.txt
# MAKE SURE that the SLURM's user can create/modify this file!

date &> ${LOGFILE}

# SlurmctldEpilog environment don't have env variables which were set in the system
# so set all needed environment varables here
# 
# export VINSNL_SERVER="localhost:9996" 

whoami &>> ${LOGFILE}
echo "directory: $PWD" &>> ${LOGFILE}
## 
# echo "using config file: $VINSNL_CONFIG" &>> ${LOGFILE}

## $VINSNL_CONFIG is not propogated by Slurm, so configure the address from CLI manually
/xch/sevi/build/sevi -c /xch/scripts/slurm/vinsnl.json &>> ${LOGFILE}

