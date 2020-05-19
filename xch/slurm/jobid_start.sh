#!/bin/bash
echo JOB_ID=$SLURM_JOBID > /var/run/ldms_jobinfo.data
echo JOB_USER_ID=$SLURM_UID >> /var/run/ldms_jobinfo.data
echo JOB_USER=$SLURM_JOB_USER >> /var/run/ldms_jobinfo.data
