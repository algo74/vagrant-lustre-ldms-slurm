#!/bin/bash

#echo "just sleep"

sbatch -N 1 --time=5 /xch/scripts/jobs/sleep-batch 120
