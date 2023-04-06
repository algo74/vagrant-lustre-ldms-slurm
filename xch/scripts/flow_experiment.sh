#!/bin/bash

MYDIR=/xch/results
OUT_FOLDER="$MYDIR/$(date +%F.%H%M%S)-flow/"

echo "Output folder: ${OUT_FOLDER}"
mkdir -p "$OUT_FOLDER"

# Canary application
/xch/scripts/demonize.sh /xch/logs/canary.pid "$OUT_FOLDER/canary.log" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 256 -s 16 -f /lustre/all/tt -m 1 -r "$OUT_FOLDER/canary.csv"

# MiddleMan
/xch/scripts/demonize.sh /xch/logs/mdman.pid "$OUT_FOLDER/mdman.log" sudo /xch/scripts/mdman.sh --prefixSaveTables="$OUT_FOLDER"

# Experiment
echo "$0" "$@" >"$OUT_FOLDER/experiment_command_line.txt"
sleep 5

/xch/scripts/demonize.sh /xch/logs/flow.pid "$OUT_FOLDER/experiment.log" "$@"
