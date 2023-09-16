#!/bin/bash

# Name of the PVC to be checked
PVC_NAME="my-pvc"

# Get the PVC status
PVC_STATUS=$(kubectl get pvc "$PVC_NAME" -o=jsonpath="{.status.phase}")

# Check if the PVC is Bound
if [ "$PVC_STATUS" = "Bound" ]; then
  echo "PVC '$PVC_NAME' is in a Bound state."
  exit 0
else
  echo "PVC '$PVC_NAME' is not in a Bound state. Current status: $PVC_STATUS"
  exit 1
fi
