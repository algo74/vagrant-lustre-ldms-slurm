#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "runing tasks in isolations"

counter=1
while [ $counter -le 8 ] 
do
  sbatch -N 1 --time=30 /xch/jobs/overfile-batch
  source $DIR/slurm-wait-till-done.sh
  sbatch -N 1 --time=5 /xch/jobs/sleep-batch
  source $DIR/slurm-wait-till-done.sh
  echo "  iteration $counter complete"
  ((counter++))
done

echo "scheduling jobs"

start=`date +%s`

counter=1
while [ $counter -le 5 ] 
do
  index_i=1
  while [ $index_i -le 16 ] 
  do
    sbatch -N 1 --time=30 /xch/jobs/overfile-batch
    sleep 1
    ((index_i++))
  done
  index_i=1
  while [ $index_i -le 64 ] 
  do
    sbatch -N 1 /xch/jobs/sleep-batch
    sleep 1
    ((index_i++))
  done
  ((counter++))
done

echo "waiting for completion"

source $DIR/slurm-wait-till-done.sh

end=`date +%s`

runtime=$((end-start))

echo "jobs completed in $runtime"
