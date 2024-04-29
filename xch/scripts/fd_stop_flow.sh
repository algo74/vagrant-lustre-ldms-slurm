#!/bin/bash

SCRIPT_DIR=/xch/scripts
PID_FILE=/var/run/pid/flow.pid

if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
else
  PID=$(sudo cat $PID_FILE)
  echo "Killing flow with PID $PID"
  ps -Fjs $PID
  sudo kill -- -$PID
  # kill -- -$(ps -o pgid= -p $PID | tr -d ' ') || kill $PID
  sudo rm $PID_FILE
fi

${SCRIPT_DIR}/stop_canary.sh

${SCRIPT_DIR}/stop_mdman.sh

${SCRIPT_DIR}/ldms/stop_fd_agg.sh
sleep 2

${SCRIPT_DIR}/move_fd_results.sh