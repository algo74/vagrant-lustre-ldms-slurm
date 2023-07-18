#!/bin/bash

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

/xch/scripts/stop_canary.sh

/xch/scripts/stop_mdman.sh
