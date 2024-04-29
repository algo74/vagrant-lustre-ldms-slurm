#!/bin/bash
OWN_DIR=/xch/scripts/mdman
source $OWN_DIR/init_mman_python.source
python3 /xch/py-sim-serv/pysimserv3.py --config_file=/xch/scripts/mdman/config.yaml "$@"
