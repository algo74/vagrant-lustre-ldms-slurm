#!/bin/bash

SCRIPT_PATH=/xch/scripts/ldms

source ${SCRIPT_PATH}/ldmsd-paths.sh
ldmsd -x sock:10003 -l ${LOG_PATH}/fd_agg.log -v ERROR -r $PID_PATH/fd_agg.pid -c ${CONF_PATH}/fd_agg.conf
