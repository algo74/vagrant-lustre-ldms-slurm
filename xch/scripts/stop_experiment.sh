#!/bin/bash
# set -e
PID_FILE=/xch/logs/experiment.pid
PID=$(<${PID_FILE})
if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
  exit 0
fi
echo "PID: ${PID}"
ps -Fjs $PID

kill -- -$(ps -o pgid= -p $PID | tr -d ' ') || kill $PID
rm $PID_FILE
