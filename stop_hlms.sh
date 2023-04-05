#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

n=${1:-8}

$DIR/ssh_clx.sh $n /xch/HLMS23/kill_local_hlms.sh
