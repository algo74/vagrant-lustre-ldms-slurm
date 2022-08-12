#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
max=$1
shift
for ((n=1;n<=$max;n++)); 
do
  echo -e "${GREEN}====== ${RED}node cl${n}${GREEN} =========${NC}"
  vagrant ssh -c "$*" cl$n
done
