#!/bin/bash
#file   : run.sh
#author : ning
#date   : 2014-01-06 16:30:21

CLUSTER='cluster0'

#test basic
./bin/deploy.py $CLUSTER deploy
./bin/deploy.py $CLUSTER start
./bin/deploy.py $CLUSTER printcmd
./bin/deploy.py $CLUSTER status
./bin/deploy.py $CLUSTER log
./bin/deploy.py $CLUSTER mastercmd 'PING'
./bin/deploy.py $CLUSTER rdb

#test bench
./bin/deploy.py $CLUSTER mlive_qps &
./bin/deploy.py $CLUSTER nbench 1000
pkill -f './bin/deploy.py'

#test failover
./bin/deploy.py $CLUSTER scheduler &
./bin/deploy.py $CLUSTER randomkill 5

#should got not error here
sleep 180

./bin/deploy.py $CLUSTER stop
pkill -f './bin/deploy.py'
