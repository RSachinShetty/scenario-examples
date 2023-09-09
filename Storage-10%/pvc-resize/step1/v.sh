#!/bin/bash

# PVC Specifications
pvc_name="yellow-pvc-cka"
requested_storage="60Mi"

# Verify PVC Status
pvc_status=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.status.phase}')

if [ "$pvc_status" == "Bound" ]; then
  echo "PVC $pvc_name is in Bound status."
else
  echo "Error: PVC $pvc_name is not in Bound status."
  exit 1
fi

# Verify PVC Storage Request
pvc_storage=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')

if [ "$pvc_storage" == "$requested_storage" ]; then
  echo "PVC $pvc_name has the correct storage request."
else
  echo "Error: PVC $pvc_name does not have the correct storage request."
  exit 1
fi

echo "Validation successful!"