#!/bin/bash
export PYTHONPATH=/usr/local/lib/python2.7/site-packages/:$PYTHONPATH
export LD_LIBRARY_PATH=usr/local/lib/:$LD_LIBRARY_PATH
python /xch/py-sim-serv/pysimserv.py
