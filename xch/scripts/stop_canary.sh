#!/bin/bash
set -e
PID_PATH=/xch/logs/canary.pid
PID=$(<${PID_PATH})

echo "PID: ${PID}"

kill -- $PID
rm $PID_PATH
