#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
    echo "USAGE: ./start-all.sh [slave-num]"
    echo "the param [slave-num] is optional, default 3"
}

run() {
    cd $DIR && docker-compose up -d zk1 zk2 zk3 master masterb slave
    cd $DIR && docker-compose scale slave=$1
    cd $DIR && docker-compose run driver
}

if [ "$#" -eq "0" ]; then
    run 3;
elif [ "$#" -eq "1" ] && [ "$1" -ge "1" ] 2>/dev/null; then
    run $1;
else
    usage;
fi
