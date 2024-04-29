#!/bin/bash

LOGFILE=/xch/logs/slurm/run_workaround_epologue.log
# MAKE SURE that the SLURM's user can create/modify this file!
date > ${LOGFILE}
exec &>> ${LOGFILE}

STARTTIME=$(SLURM_CONF="/xch/scripts/slurm/slurm.conf" squeue -j $SLURM_JOB_ID -h -O StartTime)
ENDTIME=$(date +"%Y-%m-%dT%T")
NODELIST=$SLURM_JOB_NODELIST

# Get host name and port number from the config json file
VINSNL_CONFIG=/xch/scripts/slurm/vinsnl.json
HOST=$(jq -r '.server.name' $VINSNL_CONFIG)
PORT=$(jq -r '.server.port' $VINSNL_CONFIG)

# set up python as needed
echo python3 /xch/py-sim-serv/request3.py -host=$HOST -port=$PORT -type=process_job -job_id=$SLURM_JOB_ID -variety_id=$LDMS_VARIETY_ID -job_start="$STARTTIME" -job_end="$ENDTIME" -job_nodes="$NODELIST"
python3 /xch/py-sim-serv/request3.py -host=$HOST -port=$PORT -type=process_job -job_id=$SLURM_JOB_ID -variety_id=$LDMS_VARIETY_ID -job_start="$STARTTIME" -job_end="$ENDTIME" -job_nodes="$NODELIST"

