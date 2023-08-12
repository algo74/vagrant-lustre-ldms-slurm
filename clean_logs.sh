#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# cd to the script directory
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

vagrant halt /cl[0-8]/
rm xch/logs/ldms/*
rm xch/logs/slurm/*
rm xch/logs/jobs/*
