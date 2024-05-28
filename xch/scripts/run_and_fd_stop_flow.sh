#!/bin/bash
SCR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


"$@"

sleep 30
$SCR_DIR/fd_stop_flow.sh -f