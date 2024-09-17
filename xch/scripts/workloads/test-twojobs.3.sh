#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "runing tasks in isolations"

PRE=${1:-5}
CYCLES=${2:-2}
N_JOBS_1=${3:-2}
N_JOBS_2=${4:-2}

CUR_JOB_ID=None
FIRST_JOB_ID=None
LAST_JOB_ID=None

submit_job() {
  CUR_JOB_ID=$(sbatch --parsable $@)
  # set FIRST_JOB_ID if it is not set
  if [[ $FIRST_JOB_ID == "None" ]]; then
    FIRST_JOB_ID=$CUR_JOB_ID
  fi
  echo Submitted job $CUR_JOB_ID
}

job1() {
  submit_job --job-name=job1 -N 1 --time=50 /xch/scripts/jobs/adj-batch 32 32 16 0
}

job2() {
  submit_job --job-name=job2 -N 1 --time=40 /xch/scripts/jobs/adj-batch 32 32 8 100
}

job3() {
  submit_job --job-name=job3 -N 1 --time=20 /xch/scripts/jobs/adj-batch 32 32 6 200
}

job4() {
  submit_job --job-name=job4 -N 1 --time=20 /xch/scripts/jobs/adj-batch 32 32 4 300
}

job5() {
  submit_job --job-name=job5 -N 1 --time=30 /xch/scripts/jobs/adj-batch 32 32 2 400
}

job6() {
  submit_job --job-name=job6 -N 1 --time=40 /xch/scripts/jobs/sleep-batch
}

dispatch() {
  index_i=1
  N_JOBS=$1
  # shift
  while [ $index_i -le $N_JOBS ]
  do
    $2
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
  # job2
  # source $DIR/slurm-wait-till-done.sh
  # job3
  # source $DIR/slurm-wait-till-done.sh
  # job4
  # source $DIR/slurm-wait-till-done.sh
  # job5
  # source $DIR/slurm-wait-till-done.sh
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
  dispatch $N_JOBS_1 job1
  # dispatch job2
  # dispatch job3
  # dispatch job4
  # dispatch job5
  dispatch $N_JOBS_2 job6
  echo "   -  -  iteration $counter complete  -  -  - "
  ((counter++))
done

LAST_JOB_ID=$CUR_JOB_ID

echo "waiting for completion"

source $DIR/slurm-wait-till-done.sh

end=`date +%s`

runtime=$((end-start))

echo "jobs completed in $runtime"
echo " ------ errors ------"
files=$(seq -f "/xch/logs/jobs/slurm-%g.out" ${FIRST_JOB_ID} ${LAST_JOB_ID})
grep -n 'error' $files
echo " -- end errors -----"