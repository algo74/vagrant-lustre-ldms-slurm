#!/bin/bash
OUT_DIR=${1:-"/xch/results/$(date +%F.%H%M%S)"}

mkdir -p "$OUT_DIR"

echo "Canary output directory: ${OUT_DIR}"

/xch/scripts/demonize.sh /var/run/pid/canary.pid "$OUT_DIR/canary.log" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 256 -s 16 -f /lustre/all/tt -m 1 -r "$OUT_DIR/canary.csv"
