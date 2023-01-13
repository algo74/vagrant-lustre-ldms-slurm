#!/bin/bash
# return 0
DELAY=${1:-1}
while : ; do
  result=$(squeue -h)
  # echo $result
  [[ -z "$result" ]] && break
  sleep $DELAY
done
