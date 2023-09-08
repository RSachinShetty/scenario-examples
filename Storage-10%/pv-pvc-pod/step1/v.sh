#!/bin/bash

# Function to check if a resource exists
check_resource() {
  local resource_type="$1"
  local resource_name="$2"
  if kubectl get "$resource_type" "$resource_name" &> /dev/null; then
    echo "$resource_type $resource_name exists."
  else
    echo "Error: $resource_type $resource_name does not exist."
    exit 1
  fi
}

# Verify PV
check_resource "pv" "my-pv-cka"
pv_info=$(kubectl describe pv my-pv-cka)

# Check storage capacity
if [[ $pv_info =~ Capacity:[[:space:]]*100Mi ]]; then
  echo "PV my-pv-cka has the correct storage capacity."
else
  echo "Error: PV my-pv-cka does not have the correct storage capacity."
  exit 1
fi

# Check access mode
pv_name="my-pv-cka"
if kubectl get pv "$pv_name" &> /dev/null; then
  # Get PV details in JSON format
  pv_info_json=$(kubectl get pv "$pv_name" -o json)

  # Extract access mode using Python
  access_mode=$(kubectl get pv my-pv-cka -o=jsonpath='{.spec.accessModes[*]}')

  # Check access mode
  if [[ "$access_mode" == "ReadWriteOnce" ]]; then
    echo "PV $pv_name has the correct access mode."
  else
    echo "Error: PV $pv_name does not have the correct access mode."
    exit 1
  fi
else
  echo "Error: PV $pv_name does not exist."
  exit 1
fi

# Check host path
if [[ $pv_info =~ Path:[[:space:]]*/mnt/data ]]; then
  echo "PV my-pv-cka has the correct host path."
else
  echo "Error: PV my-pv-cka does not have the correct host path."
  exit 1
fi

# Verify PVC
check_resource "pvc" "my-pvc-cka"
pvc_info=$(kubectl describe pvc my-pvc-cka)

access_mode=$(kubectl get pvc my-pvc-cka -o=jsonpath='{.spec.accessModes[*]}')
# Check access mode
if [[ "$access_mode" == "ReadWriteOnce" ]]; then
  echo "PVC my-pvc-cka has the correct access mode."
else
  echo "Error: PVC my-pvc-cka does not have the correct access mode."
  exit 1
fi

# Check storage request size
storage_value=$(kubectl get pvc -o=jsonpath='{range .items[?(@.spec.resources.requests.storage=="100Mi")]}{@.spec.resources.requests.storage}{end}')
if [[ $storage_value == "100Mi" ]]; then
  echo "PVC my-pvc-cka has the correct storage request size."
else
  echo "Error: PVC my-pvc-cka does not have the correct storage request size."
  exit 1
fi

# Verify Pod
check_resource "pod" "my-pod-cka"
sleep 25  # Wait for 25 seconds to allow the pod to become Running
pod_status=$(kubectl get pod my-pod-cka -o jsonpath='{.status.phase}')
if [ "$pod_status" == "Running" ]; then
  echo "Pod my-pod-cka is in a Running state."
  exit 0
else
  echo "Error: Pod my-pod-cka is not in a Running state. Current state: $pod_status"
  exit 1
fi