#!/bin/bash
function fail()
{
	echo Error: "$@" >&2
	exit 1
}

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

read -p "how many instanse you need?(default 1): " N_INSTANSE
if [ -z "$N_INSTANSE" ]
  then  
    N_INSTANSE=1
fi

echo check requirements
docker &> /dev/null || fail "docker not installed ... install with 'curl -fsSl https://get.docker.com |sh'"
docker-compose --version &> /dev/null  || fail "docker-compose not installed"

if [ ! -f ./id_rsa.pub  ]; then
    if [ ! -f /home/$USER/.ssh/id_rsa.pub  ]; then
    echo "id_rsa.pub not found ... lets generate it"
    ssh-keygen -A -v
    fi
    cp /home/$USER/.ssh/id_rsa.pub .
fi

docker-compose down &> /dev/null


echo lets build Dockerfile

docker build . -t ubuntu-ssh 1> /dev/null
docker-compose up --scale ubuntu-with-sshd=$N_INSTANSE -d &> /dev/null

echo "your instanses ip:(see again with 'cat hosts.ini')"

for i in `cat hosts.ini` ; do ssh-keygen -f "$HOME/.ssh/known_hosts" -R $i ; done

docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' `docker network inspect   -f '{{ range $key, $value := .Containers }}{{ printf "%s\n" $key}}{{ end }}' docker-ubuntu-ssh_ubuntu-sshd-network` 1> hosts.ini

echo -ne "${YELLOW}" ; cat hosts.ini ;echo -ne "${NC}"
echo -e "${GREEN}username: ubuntu${NC}"
echo -e "${GREEN}password: ubuntu${NC}"
echo note: run root command with sudo and it\'s doesn\'t need password
echo -e "for destroye stack : ${RED}docker-compose down${NC}"
echo -e  '#!/bin/bash\ndocker-compose down\nfor i in `cat hosts.ini` ; do ssh-keygen -f "$HOME/.ssh/known_hosts" -R $i &> /dev/null  ; done\nrm hosts.ini &> /dev/null\nrm unstack.sh' > unstack.sh
chmod +x unstack.sh 
