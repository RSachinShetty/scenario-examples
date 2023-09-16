#!/bin/bash

# Check if the deployment exists
if kubectl get deployment cache-deployment &> /dev/null; then
    echo "Validation PASSED: Deployment cache-deployment exists."
else
    echo "Validation FAILED: Deployment cache-deployment does not exist."
    exit 1
fi

# Check if the replica count is set to 2
replica_count=$(kubectl get deployment cache-deployment -o=jsonpath='{.spec.replicas}')
if [ "$replica_count" -eq 2 ]; then
    echo "Validation PASSED: Replica count for cache-deployment is 2."
else
    echo "Validation FAILED: Replica count for cache-deployment is not 2."
    exit 1
fi

# Check if the strategy type is RollingUpdate
strategy_type=$(kubectl get deployment cache-deployment -o=jsonpath='{.spec.strategy.type}')
if [ "$strategy_type" == "RollingUpdate" ]; then
    echo "Validation PASSED: Deployment strategy type is RollingUpdate."
else
    echo "Validation FAILED: Deployment strategy type is not RollingUpdate."
    exit 1
fi

# Check if MaxUnavailable is set to 30%
max_unavailable=$(kubectl get deployment cache-deployment -o=jsonpath='{.spec.strategy.rollingUpdate.maxUnavailable}')
if [ "$max_unavailable" == "30%" ]; then
    echo "Validation PASSED: MaxUnavailable is set to 30%."
else
    echo "Validation FAILED: MaxUnavailable is not set to 30%."
    exit 1
fi

# Check if MaxSurge is set to 45%
max_surge=$(kubectl get deployment cache-deployment -o=jsonpath='{.spec.strategy.rollingUpdate.maxSurge}')
if [ "$max_surge" == "45%" ]; then
    echo "Validation PASSED: MaxSurge is set to 45%."
else
    echo "Validation FAILED: MaxSurge is not set to 45%."
    exit 1
fi

image_name=$(kubectl get deployment cache-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image_name" == "redis:7.2.1" ]; then
    echo "Validation PASSED: Deployment is using the correct image (redis:7.2.1)."
else
    echo "Validation FAILED: Deployment is not using the correct image (redis:7.2.1)."
    exit 1
fi


# Wait for all pods to be ready
if kubectl wait --for=condition=Ready pods -l app=cache --timeout=300s; then
    echo "Validation PASSED: All pods are in a ready state."
else
    echo "Validation FAILED: Not all pods are in a ready state."
    exit 1
fi

# Examine the rolling history and save the total revision count
expected_total_revisions=$(kubectl rollout history deployment cache-deployment | grep -c '[0-9]')
echo "$expected_total_revisions" > total-revision.txt
total_revisions=$(cat total-revision.txt)
if [ "$expected_total_revisions" == "$total_revisions" ]; then
    echo "Validation PASSED: Revision count correct"
else
   echo "Validation PASSED: Revision count wrong"
    exit 1
fi

echo "Validation PASSED"
