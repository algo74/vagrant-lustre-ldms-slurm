FD_AGG_DIR=/xch/tests/agg
LAST_EXPERIMENT_FILE=${FD_AGG_DIR}/last_experiment

if [[ ! -f ${LAST_EXPERIMENT_FILE} ]]; then
    echo "No file with last experiment folder name found at ${LAST_EXPERIMENT_FILE}"
    exit 1
fi
LAST_EXPERIMENT=$(cat ${LAST_EXPERIMENT_FILE})
if [[ ! -d ${LAST_EXPERIMENT} ]]; then
    echo "No last experiment folder found at ${LAST_EXPERIMENT}"
    exit 1
fi
# move FD aggregator results to the results folder
mkdir -p ${LAST_EXPERIMENT}/fd_csv
mv ${FD_AGG_DIR}/fd_csv/*.csv ${LAST_EXPERIMENT}/fd_csv
rm -f ${LAST_EXPERIMENT_FILE}