#!/bin/bash
set -e
PID_FILE=/var/run/pid/mdman.pid
if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
  exit 0
fi
# PID=$(sudo cat $PID_FILE)
PID=$(<${PID_FILE})

echo "PID: ${PID}"
ps -Fjs $PID

sudo kill -- -$(ps -o pgid= -p $PID | tr -d ' ')
sudo rm $PID_FILE
