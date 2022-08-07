#!/bin/bash
set -e
PID_PATH=/xch/logs/mdman.pid
PID=$(<${PID_PATH})

echo "PID: ${PID}"

sudo kill -- -$(ps -o pgid= -p $PID | tr -d ' ')
sudo rm $PID_PATH
