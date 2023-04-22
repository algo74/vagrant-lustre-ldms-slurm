#!/bin/bash

PID_FILE=/var/run/pid/flow.pid
if [[ ! -f "$PID_FILE" ]]
then
  echo "No PID file found at $PID_FILE"
  exit 0
fi
PID=$(sudo cat $PID_FILE)
ps -Fjs $PID
sudo kill -- -$PID
# kill -- -$(ps -o pgid= -p $PID | tr -d ' ') || kill $PID
sudo rm $PID_FILE



# MYDIR=/xch/results
# OUT_FOLDER="$MYDIR/$(date +%F.%H%M%S)-flow/"

# echo "Output folder: ${OUT_FOLDER}"
# mkdir -p "$OUT_FOLDER"

# # Canary application
# /xch/scripts/demonize.sh /xch/logs/canary.pid "$OUT_FOLDER/canary.log" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 256 -s 16 -f /lustre/all/tt -m 1 -r "$OUT_FOLDER/canary.csv"

# # MiddleMan
# /xch/scripts/demonize.sh /xch/logs/mdman.pid "$OUT_FOLDER/mdman.log" sudo /xch/scripts/mdman.sh --prefixSaveTables="$OUT_FOLDER"

# # Experiment
# echo "$0" "$@" >"$OUT_FOLDER/experiment_command_line.txt"
# sleep 5

# /xch/scripts/demonize.sh /xch/logs/flow.pid "$OUT_FOLDER/experiment.log" "$@"
