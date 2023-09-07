#!/bin/bash

# Verify PV
pv_name="my-pv-cka"
if kubectl get pv "$pv_name" &> /dev/null; then
  # Get PV details
  pv_info=$(kubectl describe pv "$pv_name")

  # Check storage capacity
  if echo "$pv_info" | grep -q "Capacity:.*100Mi"; then
    echo "PV $pv_name has the correct storage capacity."
  else
    echo "Error: PV $pv_name does not have the correct storage capacity."
    exit 1
  fi

  # Check access mode
  if echo "$pv_info" | grep -q "Access Modes:\s*ReadWriteOnce"; then
    echo "PV $pv_name has the correct access mode."
  else
    echo "Error: PV $pv_name does not have the correct access mode."
    exit 1
  fi

  # Check host path
  if echo "$pv_info" | grep -q "Path:\s*/mnt/data"; then
    echo "PV $pv_name has the correct host path."
  else
    echo "Error: PV $pv_name does not have the correct host path."
    exit 1
  fi

else
  echo "Error: PV $pv_name does not exist."
  exit 1
fi

# Verify PVC
pvc_name="my-pvc-cka"
if kubectl get pvc "$pvc_name" &> /dev/null; then
  # Get PVC details
  pvc_info=$(kubectl describe pvc "$pvc_name")

  # Check access mode
  if echo "$pvc_info" | grep -q "Access Modes:\s*ReadWriteOnce"; then
    echo "PVC $pvc_name has the correct access mode."
  else
    echo "Error: PVC $pvc_name does not have the correct access mode."
    exit 1
  fi

  # Check storage request size (adjust the value as needed)
  if echo "$pvc_info" | grep -q "Storage:.*100Mi"; then
    echo "PVC $pvc_name has the correct storage request size."
  else
    echo "Error: PVC $pvc_name does not have the correct storage request size."
    exit 1
  fi

else
  echo "Error: PVC $pvc_name does not exist."
  exit 1
fi

# Verify Pod
pod_name="my-pod-cka"
if kubectl get pod "$pod_name" &> /dev/null; then
  sleep 25  # Wait for 25 seconds to allow the pod to become Running
  pod_status=$(kubectl get pod "$pod_name" -o jsonpath='{.status.phase}')
  if [ "$pod_status" == "Running" ]; then
    echo "Pod $pod_name is in a Running state."
    exit 0
  else
    echo "Error: Pod $pod_name is not in a Running state. Current state: $pod_status"
    exit 1
  fi
else
  echo "Error: Pod $pod_name does not exist."
  exit 1
fi
