#!/bin/bash

# Define the path to the pod-filter.sh script
script_path="svc-filter.sh"

# Check if the script contains the desired command
if grep -q "kubectl get svc redis-service -o jsonpath='{.spec.ports[0].targetPort}'" "$script_path"; then
  echo "Validation Successful: The command exists in the script."
  exit 0
else
  echo "Validation Failed: The command does not exist in the script."
  exit 1
fi
