#!/bin/bash

# Expected image and command
expected_image="nginx"
expected_command="sleep"

# Verify Pod Status
pod_status=$(kubectl get pod sleep-pod -o=jsonpath='{.status.phase}')
if [ "$pod_status" == "Running" ]; then
  echo "Pod $pod_name is in Running state."
else
  echo "Error: Pod $pod_name is not in the expected Running state."
  exit 1
fi

# Get the pod's image using JSONPath
actual_image=$(kubectl get pod sleep-pod -n default -o jsonpath='{.spec.containers[0].image}')

# Get the pod's command using JSONPath
actual_command=$(kubectl get pod sleep-pod -n default -o jsonpath='{.spec.containers[0].command[0]}')

# Check if the actual image and command match the expected values
if [ "$actual_image" == "$expected_image" ] && [ "$actual_command" == "$expected_command" ]; then
    echo "Validation passed: Pod 'sleep-pod' is running with the correct image and command."
    exit 0
else
    echo "Validation failed: Pod 'sleep-pod' is not running with the correct image and command."
    exit 1
fi
