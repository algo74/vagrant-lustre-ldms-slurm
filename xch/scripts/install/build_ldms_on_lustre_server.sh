#!/bin/bash

set -xe

echo "--- Installing tools needed to build LDMS"

yum -y install autoconf openssl-devel \
  automake libtool make bison flex \
  git

echo "--- Installing LDMS"

mkdir -p /source/ldms
cd /source/ldms

# getting src
git clone --single-branch -b lustre-fulldump https://github.com/algo74/ldms-fast-sample.git ovis
cd ovis
# building
./autogen.sh
mkdir build
cd build
../configure --prefix=/usr/local/ovis
make
sudo make install
cd ../..