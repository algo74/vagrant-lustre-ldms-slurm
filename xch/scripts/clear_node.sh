#!/bin/bash

sudo pkill ldms
sudo pkill slurm

sudo rm -rf /LDMS_data/simple_agg/csv
#sudo rm -rf /LDMS_data/SOS/results
sudo su -c "rm -rf /LDMS_data/SOS/sos1/*"

# refactored logs to /xch/logs
#sudo su -c "rm /source/logs/*"

# TODO: is this needed anymore?
sudo rm -rf /lustre/out
sudo mkdir /lustre/out
sudo chmod 777 /lustre/out

