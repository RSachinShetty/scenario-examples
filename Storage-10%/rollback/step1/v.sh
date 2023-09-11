#!/bin/bash

# Check if the file 'rolling-back-image.txt' exists
if [ ! -f "rolling-back-image.txt" ]; then
    echo "Validation FAILED: The file 'rolling-back-image.txt' does not exist."
    exit 1
fi

# Read the contents of the file and store it in a variable
image_content=$(cat rolling-back-image.txt)

# Check if the file contains the expected image version 'redis:7.0.13'
if [ "$image_content" == "redis:7.0.13" ]; then
    echo "Validation PASSED: The file 'rolling-back-image.txt' contains 'redis:7.0.13'."
else
    echo "Validation FAILED: The file 'rolling-back-image.txt' does not contain 'redis:7.0.13'."
    exit 1
fi

# Check the number of replicas for the 'redis-deployment'
replica_count=$(kubectl get deployment redis-deployment -o=jsonpath='{.spec.replicas}')

if [ "$replica_count" -eq 3 ]; then
    echo "Validation PASSED: Deployment 'redis-deployment' is running with 3 replicas."
else
    echo "Validation FAILED: Deployment 'redis-deployment' is not running with 3 replicas."
    exit 1
fi

echo "Validation PASSED"
