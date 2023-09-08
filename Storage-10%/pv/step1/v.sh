#!/bin/bash

# Define the PV name
pv_name="black-pv-cka"

# Fetch PV details using kubectl
pv_capacity=$(kubectl get pv "$pv_name" -o jsonpath='{.spec.capacity.storage}')
pv_host_path=$(kubectl get pv "$pv_name" -o jsonpath='{.spec.hostPath.path}')
pv_access_mode=$(kubectl get pv "$pv_name" -o jsonpath='{.spec.accessModes[0]}')

# Check if the PV exists
if kubectl get pv "$pv_name" &> /dev/null; then
  # Check storage capacity
  if [ "$pv_capacity" == "50Mi" ]; then
    echo "PV $pv_name has the correct storage capacity."
  else
    echo "Error: PV $pv_name does not have the correct storage capacity."
    exit 1
  fi

  # Check volume type
  if [ "$pv_host_path" == "/opt/black-pv-cka" ]; then
    echo "PV $pv_name has the correct path."
  else
    echo "Error: PV $pv_name does not have the correct path."
    exit 1
  fi

  # Check access mode
  if [ "$pv_access_mode" == "ReadWriteOnce" ]; then
    echo "PV $pv_name has the correct access mode."
  else
    echo "Error: PV $pv_name does not have the correct access mode."
    exit 1
  fi
else
  echo "Error: PV $pv_name does not exist."
  exit 1
fi
