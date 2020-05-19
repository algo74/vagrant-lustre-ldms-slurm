#!/bin/bash
TOP=/source/ovis

export LD_LIBRARY_PATH=$TOP/lib/:$TOP/lib64:$LD_LIBRARY_PATH
export LDMSD_PLUGIN_LIBPATH=$TOP/lib/ovis-ldms/ 
export ZAP_LIBPATH=$TOP/lib/ovis-lib/ 
export PATH=$TOP/sbin:$TOP/bin:$PATH 
export PYTHONPATH=$TOP/lib/python2.7/site-packages/:/usr/local/lib/python2.7/site-packages/:$PYTHONPATH

export SAMPLE_INTERVAL=1000000

if [[ $HOSTNAME =~ cl([0-9]) ]] ; then
  export HOSTINDEX=${BASH_REMATCH[1]}
fi

echo "LDMS setup complete, index: ${HOSTINDEX}"
