#!/bin/bash

MYDIR=/xch/results
SCRIPT_DIR=/xch/scripts
OUT_FOLDER="$MYDIR/$(date +%F.%H%M%S)-flow/"

echo "Output folder: ${OUT_FOLDER}"
mkdir -p "$OUT_FOLDER"

# Canary application
# /xch/scripts/start_canary.sh "$OUT_FOLDER"
# /xch/scripts/demonize.sh /xch/logs/canary.pid "$OUT_FOLDER/canary.log" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 256 -s 16 -f /lustre/all/tt -m 1 -r "$OUT_FOLDER/canary.csv"

# MiddleMan
/xch/scripts/start_mdman.sh "$OUT_FOLDER"

# Experiment
echo "$0" "$@" >"$OUT_FOLDER/experiment_command_line.txt"
sleep 5

"$@" | tee "$OUT_FOLDER/experiment.log"

# finish and clean up
${SCRIPT_DIR}/stop_flow.sh
${SCRIPT_DIR}/clear_node.sh
sudo ${SCRIPT_DIR}/su_clean_mdman.sh

# copy results
cp /xch/logs/slurm/lustre_log.csv "$OUT_FOLDER"

#exit
