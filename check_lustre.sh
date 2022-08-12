GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

while (( "$#" ))
do 
	echo -e "${GREEN}====== ${RED}node ${1}${GREEN} =========${NC}"
	vagrant ssh -c "/xch/scripts/check_lustre.sh" $1
	shift
done
