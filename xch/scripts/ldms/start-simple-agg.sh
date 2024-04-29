#!/bin/bash

SCRIPT_PATH=/xch/scripts/ldms

source ${SCRIPT_PATH}/ldmsd-paths.sh
# ldmsd -m 1M -x sock:10002 -l ${LOG_PATH}/agg.log -v DEBUG -r $PID_PATH/simple_agg.pid -c ${CONF_PATH}/simple_agg.conf
ldmsd -m 10M -x sock:10002 -l ${LOG_PATH}/simple_agg.log -v ERROR -r $PID_PATH/simple_agg.pid -c ${CONF_PATH}/simple_agg.conf
