#!/bin/bash

LOGFILE=/xch/logs/slurm/run_sevi_log.txt
# MAKE SURE that the SLURM's user can create/modify this file!

date &> ${LOGFILE}

# SlurmctldEpilog environment don't have env variables which were set in the system
# so set all needed environment varables here
# 
# export VINSNL_SERVER="localhost:9996" 

echo "directory: $PWD" &>> ${LOGFILE}
whoami &>> ${LOGFILE}
echo "using server: $VINSNL_SERVER" &>> ${LOGFILE}
/xch/scripts/slurm/sevi &>> ${LOGFILE}

