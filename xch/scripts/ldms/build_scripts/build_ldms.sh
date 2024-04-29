#!/bin/bash

BUILD_DIR=${1:-~/source/ldms/build}

echo "--- Building LDMS from $BUILD_DIR from scratch"
set -xe

./reconfig.sh
make
sudo make install