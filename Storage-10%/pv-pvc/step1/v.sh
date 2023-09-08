#!/bin/bash

# Define PV and PVC names
pv_name="gold-pv-cka"
pvc_name="gold-pvc-cka"

# Validate PV
pv_info=$(kubectl get pv "$pv_name" -o json)

# Check if PV exists
if [ -z "$pv_info" ]; then
  echo "Error: PV $pv_name does not exist."
  exit 1
fi

# Get PV details using kubectl commands
access_modes=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.accessModes[0]}')
storage_class=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.storageClassName}')
node_affinity=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.nodeAffinity.required.nodeSelectorTerms[0].matchExpressions[0].values[0]}')
host_path=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.hostPath.path}')

# Check PV details
if [ "$access_modes" == "ReadWriteMany" ] && [ "$storage_class" == "gold-stc-cka" ] && [ "$node_affinity" == "node01" ] && [ "$host_path" == "/opt/gold-stc-cka" ]; then
  echo "PV $pv_name meets the criteria."
else
  echo "Error: PV $pv_name does not meet the criteria."
  exit 1
fi

# Validate PVC
pvc_info=$(kubectl get pvc "$pvc_name" -o json)

# Check if PVC exists
if [ -z "$pvc_info" ]; then
  echo "Error: PVC $pvc_name does not exist."
  exit 1
fi

# Get PVC details using kubectl commands
access_mode=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.accessModes[0]}')
storage_class=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.storageClassName}')
storage_request=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')
selector_label=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.selector.matchLabels.tier}')

# Check PVC details
if [ "$access_mode" == "ReadWriteMany" ] && [ "$storage_class" == "gold-stc-cka" ] && [ "$storage_request" == "30Mi" ] && [ "$selector_label" == "white" ]; then
  echo "PVC $pvc_name meets the criteria."
else
  echo "Error: PVC $pvc_name does not meet the criteria."
  exit 1
fi

echo "Validation successful."
