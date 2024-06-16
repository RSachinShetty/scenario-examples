#!/bin/bash

# Expected image and command
expected_image="nginx"
expected_command="sleep"

# Pod name
pod_name="sleep-pod"

# Verify Pod Status
pod_status=$(kubectl get pod "$pod_name" -o=jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod $pod_name is in Running state."
else
  echo "Error: Pod $pod_name is not in the expected Running state."
  exit 1
fi

# Get the pod's image using JSONPath
actual_image=$(kubectl get pod "$pod_name" -n default -o jsonpath='{.spec.containers[0].image}')

# Get the pod's command using JSONPath
actual_command=$(kubectl get pod "$pod_name" -n default -o jsonpath='{.spec.containers[0].command}')

# Extract the command from the JSON object
actual_command=$(echo "$actual_command" | jq -r '.[2]')

# Check if the actual image and command match the expected values
if [ "$actual_image" = "$expected_image" ] && [ -n "$(echo "$actual_command" | grep "$expected_command")" ]; then
    echo "Validation passed: Pod '$pod_name' is running with the correct image and command."
else
    echo "Validation failed: Pod '$pod_name' is not running with the correct image and command."
    exit 1
fi