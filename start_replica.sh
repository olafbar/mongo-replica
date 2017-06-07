#!/bin/bash
#############################################################
# based on : Damian Kowalewski
# git-hub: damkow
# skrypt bulk.js pochodzi ze strony: https://docs.mongodb.com/manual/tutorial/convert-replica-set-to-replicated-shard-cluster/
#############################################################
tred=`tput setaf 1`
tgrn=`tput setaf 2`
tyel=`tput setaf 11`
tres=`tput sgr0`
docker network create cluster

read -n1 -r -p "$tgrn Tworzę dockery...wciśnij [ENTER] $tres"
docker-compose -f replica_1.yml up -d
sleep 5
docker exec mongo-1-1 mongo --eval "config = {\"_id\" : \"rs1\",\"members\" : [{\"_id\" : 0,\"host\" : \"mongo-1-1:27017\"},{\"_id\" : 1,\"host\" : \"mongo-1-2:27017\"},{\"_id\" : 2,\"host\" : \"mongo-1-3:27017\"}]};rs.initiate(config)"

docker cp big.js mongo-1-1:/tmp

read -n1 -r -p "$tgrn wciśnij [ENTER] $tres"
#docker exec mongo-1-1 mongo localhost:27017/big /tmp/big.js
docker exec mongo-1-1 mongo big /tmp/big.js

