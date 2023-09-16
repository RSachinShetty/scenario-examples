#!/bin/bash

# Check if the deployment exists
deployment_exists=$(kubectl get deployment stream-deployment -o custom-columns=:.metadata.name --no-headers)

if [ "$deployment_exists" != "stream-deployment" ]; then
    echo "Deployment 'stream-deployment' does not exist."
    exit 1  # Exit with failure status code
fi

# Get the UP-TO-DATE value of the deployment
up_to_date=$(kubectl get deployment stream-deployment -o custom-columns=:.status.updatedReplicas --no-headers)

if [ "$up_to_date" -eq 1 ]; then
    echo "Deployment 'stream-deployment' is up to date."
else
    echo "Deployment 'stream-deployment' is not up to date. UP-TO-DATE value is $up_to_date."
    exit 1  # Exit with failure status code
fi
