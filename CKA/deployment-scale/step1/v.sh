#!/bin/bash

# Check if the deployment exists
if kubectl get deployment redis-deploy -n redis-ns &> /dev/null; then
    echo "Validation PASSED: Deployment redis-deploy exists."
else
    echo "Validation FAILED: Deployment redis-deploy does not exist."
    exit 1
fi

# Check if the deployment has 3 replicas
replica_count=$(kubectl get deployment redis-deploy -n redis-ns -o=jsonpath='{.spec.replicas}')
if [ "$replica_count" -eq 3 ]; then
    echo "Validation PASSED: Deployment redis-deploy has 3 replicas."
else
    echo "Validation FAILED: Deployment redis-deploy does not have 3 replicas."
    exit 1
fi

# Check if the image is "redis"
image=$(kubectl get deployment redis-deploy -n redis-ns -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image" == "redis" ]; then
    echo "Validation PASSED: Image is 'redis'."
else
    echo "Validation FAILED: Image is not 'redis'."
    exit 1
fi



# Check if all pods are running
desired_replicas=$(kubectl get deployment redis-deploy -n redis-ns -o=jsonpath='{.spec.replicas}')
current_replicas=$(kubectl get deployment redis-deploy -n redis-ns -o=jsonpath='{.status.readyReplicas}')
if [ "$desired_replicas" -eq "$current_replicas" ]; then
    echo "Validation PASSED: All pods are running."
else
    echo "Validation FAILED: Not all pods are running."
    exit 1
fi

echo "Validation PASSED"
