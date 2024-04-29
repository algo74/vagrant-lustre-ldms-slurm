#!/bin/bash

MYDIR=/xch/results
FD_AGG_DIR=/xch/tests/agg
OUT_FOLDER="$MYDIR/$(date +%F.%H%M%S)-fd_flow/"

source /xch/scripts/ldms/setup.sh

if [[ -f ${FD_AGG_DIR}/last_experiment ]]; then
    echo "Error: last_experiment file exists. The previous experiment was not stopped correctly."
    exit 1
fi

echo "Output folder: ${OUT_FOLDER}"
mkdir -p "$OUT_FOLDER"
# Save the last experiment folder to write the results when the flow is stopped
echo ${OUT_FOLDER} > ${FD_AGG_DIR}/last_experiment

# FD aggregator
/xch/scripts/ldms/start_fd_agg.sh
sleep 5
# test if the FD aggregator is running
if ! pgrep -f "ldmsd -x sock:10003" >/dev/null; then
    echo "Error: FD aggregator is not running"
    exit 1
fi
echo "FD aggregator is running"

# Canary application
/xch/scripts/start_canary.sh "$OUT_FOLDER"
# /xch/scripts/demonize.sh /xch/logs/canary.pid "$OUT_FOLDER/canary.log" /xch/canary/canary_script/canary_constant_probing.sh -a localhost:9999 -b 256 -s 16 -f /lustre/all/tt -m 1 -r "$OUT_FOLDER/canary.csv"
sleep 2
# test if the canary is running
if ! pgrep -f "canary_constant_probing.sh" >/dev/null; then
    echo "Error: Canary is not running"
    exit 1
fi
echo "Canary is running"

# MiddleMan
/xch/scripts/start_mdman.sh "$OUT_FOLDER"
sleep 10
# test if the MiddleMan is running
# TODO

# Experiment
echo "$0" "$@" >"$OUT_FOLDER/experiment_command_line.txt"
/xch/scripts/demonize.sh /var/run/pid/flow.pid "$OUT_FOLDER/experiment.log" "$@"
