#!/bin/bash
MYDIR=/xch/results
OUT_FOLDER=${1:-"$(date +%F.%H%M%S)-canary.log"}

echo "Output file: ${OUT_FILE}"

/xch/scripts/demonize.sh /var/run/pid/canary.pid "$OUT_FILE" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 256 -s 16 -f /lustre/all/tt -m 1
