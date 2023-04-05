#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
max=$1
OUT_FOLDER=${2:-"/xch/results/$(date +%F.%H%M%S)-hlms"}
shift 2
for ((n=1;n<=$max;n++)); 
do
  echo -e "${GREEN}====== ${RED}node cl${n}${GREEN} =========${NC}"
  vagrant ssh -c "/xch/HLMS23/start_local_hlms.sh ${OUT_FOLDER}/cl${n}" cl${n}
done
