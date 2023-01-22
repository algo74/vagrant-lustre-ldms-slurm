#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "runing tasks in isolations"

PRE=${1:-2}
CYCLES=${2:-2}
N_WRITE=${3:-2}
N_SLEEP=${4:-4}

counter=1
while [ $counter -le $PRE ] 
do
  sbatch -N 1 --licenses=lustre:2000 --time=30 /xch/scripts/jobs/overfile-batch
  source $DIR/slurm-wait-till-done.sh
  sbatch -N 1 --licenses=lustre:0 --time=40 /xch/scripts/jobs/sleep-batch
  source $DIR/slurm-wait-till-done.sh
  echo "  iteration $counter complete"
  ((counter++))
done

echo " =  =  =   =   =   =  scheduling jobs"

start=`date +%s`

counter=1
while [ $counter -le $CYCLES ] 
do
  index_i=1
  while [ $index_i -le $N_WRITE ] 
  do
    sbatch -N 1 --licenses=lustre:2000 --time=30 /xch/scripts/jobs/overfile-batch
    sleep 10
    ((index_i++))
  done
  index_i=1
  while [ $index_i -le $N_SLEEP ] 
  do
    sbatch -N 1 --licenses=lustre:0 --time=40 /xch/scripts/jobs/sleep-batch
    sleep 10
    ((index_i++))
  done
  echo "   -  -  iteration $counter complete  -  -  - "
  ((counter++))
done

echo "waiting for completion"

source $DIR/slurm-wait-till-done.sh

end=`date +%s`

runtime=$((end-start))

echo "jobs completed in $runtime"
