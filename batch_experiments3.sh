#!/bin/bash

echo " ----------------  Switching to io150 ----------------------"
vagrant ssh -c "/xch/scripts/reconfig/io150.sh" cl0
echo " =================  Starting batch experiment 2 ============================"
vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 10 50" cl0
vagrant reload cl0


echo " ----------------  Switching to wa ----------------------"
vagrant ssh -c "/xch/scripts/reconfig/wa.00.sh" cl0
echo " =================  Starting batch experiment 3 ============================"
vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 15 15" cl0
vagrant reload cl0



echo " ----------------  Switching to io150 ----------------------"
vagrant ssh -c "/xch/scripts/reconfig/io150.sh" cl0
echo " =================  Starting batch experiment 2 ============================"
vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 15 15" cl0
vagrant reload cl0
