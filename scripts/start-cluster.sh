#!/bin/bash

set -e 

# The default node number is 3
N=${1:-3}

# Calculate N-1 and store in Nminus1
Nminus1=$((N-1))

echo "Resizing cluster to $Nminus1 slave nodes..."
./scripts/resize-number-slaves.sh $Nminus1
if [ $? -ne 0 ]; then
    echo "Failed to resize slaves. Exiting..."
    exit 1
fi

docker build -t hdsphere-master-official:latest ./config-hadoop

echo "Starting Docker Compose services..."
docker compose -f compose-dynamic.yaml up -d
if [ $? -ne 0 ]; then
    echo "Failed to start Docker Compose services. Exiting..."
    exit 1
fi


echo "Restarting the cluster..."
docker exec -it hdsphere-master /bin/bash -c "su - hadoopquochuy026"
if [ $? -ne 0 ]; then
    echo "Failed to restart the cluster. Exiting..."
    exit 1
fi




echo "Cluster setup completed successfully!"
