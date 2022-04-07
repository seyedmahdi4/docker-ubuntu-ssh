#!/bin/bash
function fail()
{
	echo Error: "$@" >&2
	exit 1
}

echo "how many instanse you need?(default 1)"
read N_INSTANSE
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
echo your instanses ip:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' `docker network inspect   -f '{{ range $key, $value := .Containers }}{{ printf "%s\n" $key}}{{ end }}' ssh_docker_ubuntu-sshd-network`
echo username: ubuntu
echo password: ubuntu
echo note: run root command with sudo and it\'s doesn\'t need password
echo for destroye stack : docker-compose down
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
echo -e "${GREEN}finish ${NC}"
