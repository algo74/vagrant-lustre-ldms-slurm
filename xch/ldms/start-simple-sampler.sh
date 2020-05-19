#!/bin/bash


SCRIPT_PATH=/xch/ldms


source ${SCRIPT_PATH}/ldmsd-paths.sh

ldmsd -x sock:10001 -a none -l ${LOG_PATH}/sampler.log -v DEBUG -r $PID_PATH/simple_sampler.pid -c ${CONF_PATH}/simple_sampler.conf
