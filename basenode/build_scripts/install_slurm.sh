#!/bin/bash

echo "--- Installing Slurm"
set -xe

mkdir -p /source/slurm
cd /source/slurm

# getting src
git clone https://github.com/algo74/slurm-ldms.git
cd slurm-ldms
# TODO: checkout the desired commit
git checkout workload-adaptive-AG-leeway
autoreconf
./configure --enable-debug  --enable-multiple-slurmd
make
sudo make install

ldconfig -n /usr/local/lib

# configure Munge
sudo create-munge-key
sudo systemctl start munge
systemctl status munge
sudo systemctl enable munge

# Additional settings

## preventing "fatal: mkdir(/var/spool/slurmd): Permission denied"
sudo mkdir -p /var/spool/slurmd && sudo chmod 777 /var/spool/slurmd

# Extras
sudo sh -c "echo 'pathmunge /usr/local/sbin' > /etc/profile.d/path_usr_local_sbin.sh"
sudo chmod +x /etc/profile.d/path_usr_local_sbin.sh
