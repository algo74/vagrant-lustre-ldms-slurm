#!/bin/bash
PID_PATH=${1:-"/dev/null"}
LOG_PATH=${2-"/dev/null"}
shift 2

if [[ -f "$PID_PATH" ]]
then
	printf "$PID_PATH exists. Overwrite (y/n)? "
	read answer

	if [ "$answer" == "${answer#[Yy]}" ]
	then 
		echo "Exiting..."
		exit 0 
	fi
fi

"$@" &>${LOG_PATH} &
disown
PID=$!

printf '%d\n' "$!" >$PID_PATH
echo "Started $1 (PID $PID in $PID_PATH) with output to ${LOG_PATH}"
