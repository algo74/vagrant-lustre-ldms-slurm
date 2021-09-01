#!/bin/bash

echo "--- Installing LDMS"
set -xe

mkdir -p /source/ldms
cd /source/ldms


# SOS
# getting src
git clone --single-branch --branch SOS-4 https://github.com/ovis-hpc/sos
cd sos
# freezing to the commit we know works
git checkout 3177b4c7149e0ac4380c89f0c2248717ccac2066
# building
./autogen.sh 
mkdir build 
cd build 
PYTHON=/usr/bin/python3 ../configure --prefix=/usr/local/ovis
make 
sudo make install 
cd ../..

# LDMS
# getting src
git clone --single-branch --branch OVIS-4 https://github.com/ovis-hpc/ovis
cd ovis
# freezing to the commit we know works
git checkout a74b4696115e0da371fb4f633c9cdc3e072501a9
# building
./autogen.sh
mkdir build
cd build
../configure --prefix=/usr/local/ovis --enable-swig --enable-sos --with-sos=/usr/local/ovis
make
sudo make install
cd ../..

# NumSOS
git clone https://github.com/nick-enoent/numsos 
# freezing to the commit we know works
cd numsos
git checkout 1467f96979f77776a50f377cb20dc928b7b5a1ea
# building
./autogen.sh 
mkdir build 
cd build 
PYTHON=/usr/bin/python3 ../configure --prefix=/usr/local/ovis --with-sos=/usr/local/ovis 
make 
sudo make install 
