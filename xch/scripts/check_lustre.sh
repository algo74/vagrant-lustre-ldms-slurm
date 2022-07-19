#!/bin/bash

echo "--- checking lustre"
ls /proc/fs/lustre/llite
echo "lfs df"
lfs df
echo "lustre/all content: "
ls -l /lustre/all
echo "--- done"
