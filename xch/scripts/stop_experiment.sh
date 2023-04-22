#!/bin/bash
# set -e
PID_PATH=/xch/logs/experiment.pid
PID=$(<${PID_PATH})
if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
  exit 0
fi
echo "PID: ${PID}"
ps -Fjs $PID

kill -- -$(ps -o pgid= -p $PID | tr -d ' ') || kill $PID
rm $PID_PATH
