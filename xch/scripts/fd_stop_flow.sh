#!/bin/bash

SCRIPT_DIR=/xch/scripts
PID_FILE=/var/run/pid/flow.pid

# read parameter from the command line with getopts
STOP_FLOW=true
while getopts "f" opt; do
  case ${opt} in
    f )
      STOP_FLOW=false
      ;;
    \? )
      echo "Usage: $0 [-f]"
      ;;
  esac
done

if [[ $STOP_FLOW == true ]] ; then
  if [[ ! -f "$PID_FILE" ]] ; then
    echo "No PID file found at $PID_FILE"
  else
    PID=$(sudo cat $PID_FILE)
    echo "Killing flow with PID $PID"
    ps -Fjs $PID
    sudo kill -- -$PID
    # kill -- -$(ps -o pgid= -p $PID | tr -d ' ') || kill $PID
    sudo rm $PID_FILE
  fi
fi

${SCRIPT_DIR}/stop_canary.sh

${SCRIPT_DIR}/stop_mdman.sh

${SCRIPT_DIR}/ldms/stop_fd_agg.sh
sleep 2

${SCRIPT_DIR}/move_fd_results.sh

if [[ STOP_FLOW == false ]] ; then
  # Remove the PID file
  sudo rm $PID_FILE
fi