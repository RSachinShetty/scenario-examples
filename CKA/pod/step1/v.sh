#!/bin/bash

# Check if the pod exists
if kubectl get pod my-pod &> /dev/null; then
    echo "Validation PASSED: Pod my-pod exists."
else
    echo "Validation FAILED: Pod my-pod does not exist."
    exit 1
fi

# Check if the pod is running
pod_status=$(kubectl get pod my-pod -o=jsonpath='{.status.phase}')
if [ "$pod_status" == "Running" ]; then
    echo "Validation PASSED: Pod my-pod is running."
else
    echo "Validation FAILED: Pod my-pod is not running."
    exit 1
fi

# Check if the pod uses the specified image
container_image=$(kubectl get pod my-pod -o=jsonpath='{.spec.containers[0].image}')
if [ "$container_image" == "nginx:latest" ]; then
    echo "Validation PASSED: Pod my-pod is using the correct image (nginx:latest)."
else
    echo "Validation FAILED: Pod my-pod is not using the correct image (nginx:latest)."
    exit 1
fi

# Check if the pod has the correct resource limits and requests
resource_limits=$(kubectl get pod my-pod -o=jsonpath='{.spec.containers[0].resources.limits.memory}')
resource_requests=$(kubectl get pod my-pod -o=jsonpath='{.spec.containers[0].resources.requests.memory}')

if [ "$resource_limits" == "50Mi" ] && [ "$resource_requests" == "50Mi" ]; then
    echo "Validation PASSED: Pod my-pod has the correct resource limits and requests."
else
    echo "Validation FAILED: Pod my-pod does not have the correct resource limits and requests."
    exit 1
fi 

echo "Validation PASSED"
