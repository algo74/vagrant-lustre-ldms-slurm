#!/bin/bash
max=$1
shift
for ((n=1;n<=$max;n++)); 
do
  vagrant ssh -c $* cl$n
done
