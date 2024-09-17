#!/bin/bash

# vagrant ssh -c "/xch/scripts/reconfig/wa.00.sh" cl0
# vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 10 50" cl0
# vagrant reload cl0

echo " ----------------  Switching to io200 ----------------------"
vagrant ssh -c "/xch/scripts/reconfig/io200.sh" cl0
echo " =================  Starting batch experiment 1 ============================"
vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 10 50" cl0
vagrant reload cl0
echo " =================  Starting batch experiment 2 ============================"
vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 15 15" cl0
vagrant reload cl0


echo " ----------------  Switching to io300 ----------------------"
vagrant ssh -c "/xch/scripts/reconfig/io300.sh" cl0
echo " =================  Starting batch experiment 3 ============================"
vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 10 50" cl0
vagrant reload cl0
echo " =================  Starting batch experiment 4 ============================"
# vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 0 8 15 15" cl0
# vagrant reload cl0

# echo " =================  Starting batch experiment 5 ============================"
# vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 5 8 15 0" cl0
# vagrant reload cl0

# echo " ----------------  Switching to base ----------------------"
# vagrant ssh -c "/xch/scripts/reconfig/base.sh" cl0
# echo " =================  Starting batch experiment 6 ============================"
# vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 5 8 15 0" cl0
# vagrant reload cl0

# echo " ----------------  Switching to io200 ----------------------"
# vagrant ssh -c "/xch/scripts/reconfig/io200.sh" cl0
# echo " =================  Starting batch experiment 7 ============================"
# vagrant ssh -c "/xch/scripts/flow_and_exit.sh /xch/scripts/workloads/test-twojobs.3.sh 5 8 15 0" cl0
# vagrant reload cl0