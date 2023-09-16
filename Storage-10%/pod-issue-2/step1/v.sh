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

pv_status=$(kubectl get pv redis-pv -o jsonpath='{.status.phase}')
if [ "$pv_status" = "Bound" ]; then
  echo "PV is correct."
else
  echo "PV is wrong."
  exit 1
fi

pvc_status=$(kubectl get pvc redis-pvc -o jsonpath='{.status.phase}')
if [ "$pvc_status" = "Bound" ]; then
  echo "PVC is correct."
else
  echo "PVC is wrong."
  exit 1
fi