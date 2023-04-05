#!/bin/bash


FIRST_JOB_ID=9761
LAST_JOB_ID=10540

files=$(seq -f "/xch/logs/jobs/slurm-%g.out" ${FIRST_JOB_ID} ${LAST_JOB_ID})
grep -n 'error' $files