while (( "$#" ))
do 
	if [[ $(vagrant status $1) == *"not created"* ]]
	then
		echo "=== === === === creating $1"
		vagrant up $1
		echo "=== === === === restarting $1"
		vagrant halt $1
	fi
	vagrant up $1
	vagrant ssh -c "/xch/scripts/check_lustre.sh" $1
 	shift 
done
