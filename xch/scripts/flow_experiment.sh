#!/bin/bash

MYDIR=/xch/results
OUT_FOLDER="$MYDIR/$(date +%F.%H%M%S)-flow/"

echo "Output folder: ${OUT_FOLDER}"
mkdir -p "$OUT_FOLDER"

/xch/scripts/demonize.sh /xch/logs/mdman.pid "$OUT_FOLDER/mdman.log" sudo /xch/scripts/mdman.sh --prefixSaveTables="$OUT_FOLDER"

echo "$0" "$@" >"$OUT_FOLDER/experiment_command_line.txt"
sleep 3

/xch/scripts/demonize.sh /xch/logs/flow.pid "$OUT_FOLDER/experiment.log" "$@"

