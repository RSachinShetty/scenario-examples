#!/bin/bash

# Check if the deployment exists
if kubectl get deployment nginx-app-deployment &> /dev/null; then
    echo "Validation PASSED: Deployment nginx-app-deployment exists."
else
    echo "Validation FAILED: Deployment nginx-app-deployment does not exist."
    exit 1
fi

# Check if there are exactly 3 replicas in the deployment
replica_count=$(kubectl get deployment nginx-app-deployment -o=jsonpath='{.status.replicas}')
if [ "$replica_count" -eq 3 ]; then
    echo "Validation PASSED: Deployment nginx-app-deployment has 3 replicas."
else
    echo "Validation FAILED: Deployment nginx-app-deployment does not have 3 replicas."
    exit 1
fi

# Check if the image used is nginx
image_name=$(kubectl get deployment nginx-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image_name" == "nginx" ]; then
    echo "Validation PASSED: Deployment nginx-app-deployment uses the correct image (nginx)."
else
    echo "Validation FAILED: Deployment nginx-app-deployment does not use the correct image (nginx)."
    exit 1
fi

# Check if all pods are running
desired_replicas=3
current_replicas=$(kubectl get deployment nginx-app-deployment -o=jsonpath='{.status.replicas}')
if [ "$desired_replicas" -eq "$current_replicas" ]; then
    echo "Validation PASSED: All pods for nginx-app-deployment are running."
else
    echo "Validation FAILED: Not all pods for nginx-app-deployment are running."
    exit 1
fi

echo "Validation PASSED"
