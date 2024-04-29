#!/bin/bash
set -e
source /xch/scripts/ldms/ldmsd-paths.sh
PID_FILE=$PID_PATH/fd_agg.pid
if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
  exit 0
fi
PID=$(<${PID_FILE})

echo "PID: ${PID}"
ps -Fjp $PID

kill -- $PID
rm -f $PID_FILE
