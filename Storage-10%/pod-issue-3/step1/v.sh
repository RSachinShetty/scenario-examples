#!/bin/bash

# Define the Pod name and namespace
POD_NAME="frontend"
NAMESPACE="default"

# Check if the Pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi
