#!/bin/bash

SCRIPT_PATH=/xch/scripts

# init file for jobinfo
$SCRIPT_PATH/slurm/jobid_stop.sh

# start LDMS
# source $SCRIPT_PATH/ldms/setup.sh  # it is already sourced in start_fd_sampler.sh
sh $SCRIPT_PATH/ldms/start_fd_sampler.sh
# sh $SCRIPT_PATH/check_lustre.sh
