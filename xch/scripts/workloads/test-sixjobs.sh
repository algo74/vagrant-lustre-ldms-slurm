#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "runing tasks in isolations"

PRE=${1:-2}
CYCLES=${2:-2}
N_JOBS=${3:-2}

CUR_JOB_ID=None
FIRST_JOB_ID=None
LAST_JOB_ID=None

job1() {
  CUR_JOB_ID=$(sbatch --parsable --job-name=job1 -N 1 --time=50 /xch/scripts/jobs/uni-batch 512 3 100)
}

job2() {
  CUR_JOB_ID=$(sbatch --parsable --job-name=job2 -N 1 --time=40 /xch/scripts/jobs/uni-batch 512 2 300)
}

job3() {
  CUR_JOB_ID=$(sbatch --parsable --job-name=job3 -N 1 --time=20 /xch/scripts/jobs/uni-batch 512 1 200)
}

job4() {
  CUR_JOB_ID=$(sbatch --parsable --job-name=job4 -N 1 --time=20 /xch/scripts/jobs/uni-batch 512 1 400)
}

job5() {
  CUR_JOB_ID=$(sbatch --parsable --job-name=job5 -N 1 --time=30 /xch/scripts/jobs/uni-batch 512 1 800)
}

job6() {
  CUR_JOB_ID=$(sbatch --parsable --job-name=job6 -N 1 --time=40 /xch/scripts/jobs/sleep-batch)
}

dispatch() {
  index_i=1
  while [ $index_i -le $N_JOBS ] 
  do
    ${1}
    sleep 10
    ((index_i++))
  done
}

counter=1
while [ $counter -le $PRE ] 
do
  job1
  source $DIR/slurm-wait-till-done.sh
  if [[ $FIRST_JOB_ID == "None" ]]; then
    FIRST_JOB_ID=$CUR_JOB_ID
  fi
  job2
  source $DIR/slurm-wait-till-done.sh
  job3
  source $DIR/slurm-wait-till-done.sh
  job4
  source $DIR/slurm-wait-till-done.sh
  job5
  source $DIR/slurm-wait-till-done.sh
  job6
  source $DIR/slurm-wait-till-done.sh

  echo "  iteration $counter complete"
  ((counter++))
done

echo " =  =  =   =   =   =  scheduling jobs"

start=`date +%s`

counter=1
while [ $counter -le $CYCLES ] 
do
  dispatch job1
  dispatch job2
  dispatch job3
  dispatch job4
  dispatch job5
  dispatch job6
  echo "   -  -  iteration $counter complete  -  -  - "
  ((counter++))
done

LAST_JOB_ID=$CUR_JOB_ID

echo "waiting for completion"

source $DIR/slurm-wait-till-done.sh

end=`date +%s`

runtime=$((end-start))

echo "jobs completed in $runtime"

grep -n 'error' /xch/logs/jobs/slurm-{${FIRST_JOB_ID}..${LAST_JOB_ID}}.out
