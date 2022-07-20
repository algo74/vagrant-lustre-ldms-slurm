#!/bin/bash

echo "--- checking lustre"
ls /proc/fs/lustre/llite
echo "lustre/all content: "
ls -l /lustre/all
echo "lfs df"
lfs df
echo "--- done"
