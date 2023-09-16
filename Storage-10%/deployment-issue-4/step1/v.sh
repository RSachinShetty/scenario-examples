#!/bin/bash

# Define the deployment name and namespace
DEPLOYMENT_NAME="database-deployment"
NAMESPACE="default"

# Fetch the pod name from the deployment
POD_NAME=$(kubectl get pods -n "$NAMESPACE" -l app=postgres -o jsonpath='{.items[0].metadata.name}')

# Check if the pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi