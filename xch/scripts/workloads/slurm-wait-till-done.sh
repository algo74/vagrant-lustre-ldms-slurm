#!/bin/bash
# return 0
while : ; do
  result=$(squeue -h)
  # echo $result
  [[ -z "$result" ]] && break
  sleep 1
done
