#!/bin/bash

# Define the Pod name and namespace
POD_NAME="hello-kubernetes"
NAMESPACE="default"

# Check if the Pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi

# Check container name
container_name=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].name}')
if [ "$container_name" = "echo-container" ]; then
  echo "Container name is correct."
else
  echo "Container name is incorrect."
  exit 1
fi

# Check container image
container_image=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].image}')
if [ "$container_image" = "redis" ]; then
  echo "Container image is correct."
else
  echo "Container image is incorrect."
  exit 1
fi

# Check container command
container_command=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].command[0]}')
if [ "$container_command" = "sh" ]; then
  echo "Container command is correct."
else
  echo "Container command is incorrect."
  exit 1
fi

echo "Validation completed successfully."
