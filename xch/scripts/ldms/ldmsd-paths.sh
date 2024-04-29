TOP=/source/ldms/ovis

CONF_PATH=/xch/scripts/ldms
DEMO_DATA_PATH=$TOP/data
PID_PATH=/run/pid
if [[ $HOSTNAME =~ cl([0-9]) ]] ; then
  LOG_PATH=/xch/logs/ldms
else
  LOG_PATH=/dev/null
fi

