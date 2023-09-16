#!/bin/bash

# Define PVC name
pvc_name="red-pvc-cka"

# Verify if PVC exists
if kubectl get pvc "$pvc_name" &> /dev/null; then
  # Get access mode using kubectl
  access_mode=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.accessModes[0]}')
  if [ "$access_mode" == "ReadWriteOnce" ]; then
    echo "PVC $pvc_name has the correct access mode."
  else
    echo "Error: PVC $pvc_name does not have the correct access mode."
    exit 1
  fi

  # Get storage class using kubectl
  storage_class=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.storageClassName}')
  if [ "$storage_class" == "manual" ]; then
    echo "PVC $pvc_name is using the correct storage class."
  else
    echo "Error: PVC $pvc_name is not using the correct storage class."
    exit 1
  fi

  # Get storage request size using kubectl
  storage_request=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')
  if [ "$storage_request" == "30Mi" ]; then
    echo "PVC $pvc_name has the correct storage request size."
  else
    echo "Error: PVC $pvc_name does not have the correct storage request size."
    exit 1
  fi

  # Get volume name using kubectl
  volume_name=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.volumeName}')
  if [ "$volume_name" == "red-pv-cka" ]; then
    echo "PVC $pvc_name is bound to the correct volume."
  else
    echo "Error: PVC $pvc_name is not bound to the correct volume."
    exit 1
  fi

else
  echo "Error: PVC $pvc_name does not exist."
  exit 1
fi

# All criteria met
echo "PVC $pvc_name meets the criteria."
