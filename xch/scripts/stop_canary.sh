#!/bin/bash
set -e
PID_FILE=/var/run/pid/canary.pid
if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
  exit 0
fi
PID=$(<${PID_FILE})

echo "PID: ${PID}"
ps -Fjp $PID

kill -- $PID
rm $PID_FILE
