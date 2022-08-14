#!/bin/bash
set -e
PID_PATH=/xch/logs/experiment.pid
PID=$(<${PID_PATH})

echo "PID: ${PID}"

kill -- -$(ps -o pgid= -p $PID | tr -d ' ')
rm $PID_PATH
