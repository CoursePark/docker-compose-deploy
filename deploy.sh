#!/bin/sh

# extract docker-machine certificate from DOCKER_MACHINE_CERT and configure
export DOCKER_CERT_PATH=$HOME/.docker/machine/machines/cert
mkdir -p $DOCKER_CERT_PATH
cd $DOCKER_CERT_PATH
echo $DOCKER_MACHINE_CERT | base64 -d | gzip -d | tar -x
cd /

# extract dockerhub auth file
if [ ! -z "$DOCKER_CREDENTIAL" ]; then
	echo $DOCKER_CREDENTIAL | base64 -d | gzip -d > $HOME/.docker/config.json
fi

# extract docker-compose related files, docker-compose.yml must be in a
# directory named the same as previously used
cd $HOME
mkdir -p $DOCKER_COMPOSE_DIR_NAME
cd $DOCKER_COMPOSE_DIR_NAME
echo $DOCKER_COMPOSE | base64 -d | gzip -d > docker-compose.yml

docker-compose pull
docker-compose down -v
docker-compose up -d --remove-orphans
docker rmi $(docker images -a -q) || true # non 0 exit code doesn't matter for removing unused images
