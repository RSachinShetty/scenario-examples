#!/bin/bash

# Define the path to the script file
script_path="pod-filter.sh"

# Define the commands to search for
commands=("kubectl get pod nginx-pod -o=jsonpath='{.metadata.labels.application}'" "kubectl get pods nginx-pod -o=jsonpath='{.metadata.labels.application}'")

# Flag to indicate if at least one command is found
found=false

# Read the script file line by line
while IFS= read -r line; do
  for cmd in "${commands[@]}"; do
    if [[ $line == *"$cmd"* ]]; then
      found=true
      break
    fi
  done
done < "$script_path"

# Check if at least one command is found
if [ "$found" = true ]; then
  echo "Validation Successful: At least one of the commands exists in the script."
else
  echo "Validation Failed: Neither of the commands exists in the script."
  exit 1
fi