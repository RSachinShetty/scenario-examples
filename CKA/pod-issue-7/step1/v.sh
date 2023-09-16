#!/bin/bash

# Define the Pod name and namespace
POD_NAME="redis-pod"
NAMESPACE="default"

# Check if the Pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi

# Use `kubectl get` with JSONPath to retrieve the tolerations from the Pod's spec
TOLERATIONS=$(kubectl get pod "$POD_NAME" -o=jsonpath="{.spec.tolerations}")

# Check if the tolerations contain the expected value
if echo "$TOLERATIONS" | grep -q "workerNode01"; then
  echo "Pod tolerations match the expected values."
else
  echo "Pod tolerations do not match the expected values."
  exit 1
fi
