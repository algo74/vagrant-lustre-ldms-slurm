#!/bin/bash
MYDIR=/xch/results
OUT_FOLDER=${1:-"$MYDIR/$(date +%F.%H%M%S)-pysimserv/"}

echo "Output folder: ${OUT_FOLDER}"
mkdir -p "$OUT_FOLDER"

/xch/scripts/demonize.sh /var/run/pid/mdman.pid "$OUT_FOLDER/mdman.log" sudo /xch/scripts/mdman.sh --prefixSaveTables="$OUT_FOLDER"
