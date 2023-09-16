#!/bin/bash

# Define the deployment name and namespace
DEPLOYMENT_NAME="frontend-deployment"
NAMESPACE="nginx-ns"

# Fetch the pod name from the deployment
POD_NAME=$(kubectl get pods -n "$NAMESPACE" -l app=nginx -o jsonpath='{.items[0].metadata.name}')

# Check if the pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi