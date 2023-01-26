#!/bin/bash
set -xe


SCRIPT_PATH=/xch/scripts/ldms


source ${SCRIPT_PATH}/ldmsd-paths.sh

# ldmsd -x sock:10001 -a none -l ${LOG_PATH}/$HOSTNAME-sampler.log -v DEBUG -r $PID_PATH/simple_sampler.pid -c ${CONF_PATH}/simple_sampler.conf
ldmsd -x sock:10001 -a none -l ${LOG_PATH}/$HOSTNAME-sampler.log -v ERROR -r $PID_PATH/simple_sampler.pid -c ${CONF_PATH}/simple_sampler.conf
