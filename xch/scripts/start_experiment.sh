#!/bin/bash
MYDIR=/xch/results
OUT_FILE=$MYDIR/$(date +%F.%H%M%S)-experiment.log

echo "Output file: ${OUT_FILE}"

/xch/scripts/demonize.sh /xch/logs/experiment.pid "$OUT_FILE" /xch/base_exp/cio_scan.sh 20 false 512 2
