#!/bin/bash
set -xe


SCRIPT_PATH=/xch/scripts/ldms

source ${SCRIPT_PATH}/setup.sh
source ${SCRIPT_PATH}/ldmsd-paths.sh

if [[ $HOSTNAME =~ cl([0-9]) ]] ; then
  LOG_FILE=${LOG_PATH}/$HOSTNAME-fd_sampler.log
  CONF_FILE=${CONF_PATH}/fd_client_sampler.conf
elif [[ $HOSTNAME =~ mds0([0-9]) ]] ; then
  LOG_FILE=/dev/null
  CONF_FILE=${CONF_PATH}/fd_mdgs_sampler.conf
elif [[ $HOSTNAME =~ oss0([0-9]) ]] ; then
  LOG_FILE=/dev/null
  CONF_FILE=${CONF_PATH}/fd_oss_sampler.conf
else
  echo "! ! !  Unknown host: ${HOSTNAME}; cannot proceed"
  exit 1
fi

ldmsd -x sock:10001 -m 20M -a none -l ${LOG_FILE} -v ERROR -r $PID_PATH/simple_sampler.pid -c ${CONF_FILE}
