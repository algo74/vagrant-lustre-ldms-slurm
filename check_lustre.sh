while (( "$#" ))
do 
	vagrant ssh -c "/xch/scripts/check_lustre.sh" $1
	shift
done
