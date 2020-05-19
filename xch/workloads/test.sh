#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
sbatch -N 1 /xch/jobs/test
source $DIR/slurm-wait-till-done.sh
