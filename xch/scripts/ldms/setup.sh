#!/bin/bash
TOP=/usr/local/ovis

sudo mkdir -p /run/pid && sudo chmod 777 /run/pid

if [ -z "$HOSTINDEX" ] ; then

  export LD_LIBRARY_PATH=$TOP/lib/:$TOP/lib64:$LD_LIBRARY_PATH
  export LDMSD_PLUGIN_LIBPATH=$TOP/lib/ovis-ldms/
  export ZAP_LIBPATH=$TOP/lib/ovis-ldms/
  export PATH=$TOP/sbin:$TOP/bin:$PATH
  export PYTHONPATH=$TOP/lib/python3.6/site-packages/:$PYTHONPATH

  export SAMPLE_INTERVAL=1000000

  if [[ $HOSTNAME =~ cl([0-9]) ]] ; then
    export HOSTINDEX=${BASH_REMATCH[1]}
  elif [[ $HOSTNAME =~ mds0([0-9]) ]] ; then
    export HOSTINDEX=10${BASH_REMATCH[1]}
  elif [[ $HOSTNAME =~ oss0([0-9]) ]] ; then
    export HOSTINDEX=20${BASH_REMATCH[1]}
  else
    echo "! ! !  Unknown host: ${HOSTNAME}; setting HOSTINDEX=0"
    export HOSTINDEX=0
  fi

else

  echo "LDMS setup was already performed"

fi

echo "LDMS setup complete, index: ${HOSTINDEX}"
