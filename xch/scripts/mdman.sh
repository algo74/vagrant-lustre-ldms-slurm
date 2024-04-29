#!/bin/bash
TOP=/usr/local/ovis
P_ADD=$TOP/lib/python3.6/site-packages
[[ "$PYTHONPATH" != "$P_ADD:"* ]] && export PYTHONPATH=$P_ADD:$PYTHONPATH
[[ "$LD_LIBRARY_PATH" != "$TOP/lib/:"* ]] && export LD_LIBRARY_PATH=$TOP/lib/:$LD_LIBRARY_PATH
python3 /xch/py-sim-serv/pysimserv3.py --config_file=/xch/py-sim-serv/config_base_canary.yaml "$@"

