#!/bin/bash
usage () {
    echo "USAGE: $0 <port> <mode [args]>"
    exit
}

[ "$#" -lt 2 ] && usage

let "P=$1"
PORTS="-p $((P++)):5000"
VOLUMNS="-v $(readlink -f ./app):/app -v $(readlink -f ./sample_dataset):/tmp/sample_dataset"
IMAGE="aleozlx/rji_backend:0.2"
DOCKER_RUN="-it"

case "$2" in
    dev) # development mode
        # PORTS="$PORTS -p $((P++)):8888" # expose jupyter notebook
        DOCKER_CMD="/app/run.sh $2"
        ;;
    # nb) # notebook editing mode
    #     PORTS="-p $((P++)):8888" # expose jupyter notebook only
    #     DOCKER_CMD="/app/run.sh $2"
    #     ;;
    sh) # bash mode
        ;;
    *)
        usage ;;
esac

set -x
docker run $DOCKER_RUN $PORTS $VOLUMNS $IMAGE $DOCKER_CMD
