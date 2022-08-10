#!/bin/bash
MYDIR=/xch/results
OUT_FILE=$MYDIR/$(date +%F.%H%M%S)-canary.log

echo "Output file: ${OUT_FILE}"

/xch/scripts/demonize.sh /xch/logs/canary.pid "$OUT_FILE" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 65536 -s 1 -f /lustre/all/tt -m 1
