#!/bin/bash

# Step 1: Verify Storage Class (blue-stc-cka)
storage_class_name="blue-stc-cka"

provisioner=$(kubectl get storageclass "$storage_class_name" -o=jsonpath='{.provisioner}')
binding_mode=$(kubectl get storageclass "$storage_class_name" -o=jsonpath='{.volumeBindingMode}')

if [ "$provisioner" == "kubernetes.io/no-provisioner" ] && [ "$binding_mode" == "WaitForFirstConsumer" ]; then
  echo "Storage Class $storage_class_name meets the criteria."
else
  echo "Error: Storage Class $storage_class_name does not meet the criteria."
  exit 1
fi

# Step 2: Verify Persistent Volume (blue-pv-cka)
pv_name="blue-pv-cka"

capacity=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.capacity.storage}')
access_mode=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.accessModes[0]}')
reclaim_policy=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.persistentVolumeReclaimPolicy}')
storage_class=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.storageClassName}')
local_path=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.local.path}')
node_affinity=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.nodeAffinity.required.nodeSelectorTerms[0].matchExpressions[0].values[0]}')

if [ "$capacity" == "100Mi" ] && [ "$access_mode" == "ReadWriteOnce" ] && [ "$reclaim_policy" == "Retain" ] && [ "$storage_class" == "blue-stc-cka" ] && [ "$local_path" == "/opt/blue-data-cka" ] && [ "$node_affinity" == "controlplane" ]; then
  echo "Persistent Volume $pv_name meets the criteria."
else
  echo "Error: Persistent Volume $pv_name does not meet the criteria."
  exit 1
fi

# Step 3: Verify Persistent Volume Claim (PVC)
pvc_name="blue-pvc-cka"

access_mode_pvc=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.accessModes[0]}')
storage_class_pvc=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.storageClassName}')
storage_request=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')
bound_pv=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.volumeName}')

if [ "$access_mode_pvc" == "ReadWriteOnce" ] && [ "$storage_class_pvc" == "blue-stc-cka" ] && [ "$storage_request" == "50Mi" ] && [ "$bound_pv" == "blue-pv-cka" ]; then
  echo "Persistent Volume Claim $pvc_name meets the criteria."
else
  echo "Error: Persistent Volume Claim $pvc_name does not meet the criteria."
  exit 1
fi

# All checks passed
echo "All criteria for Storage Class, Persistent Volume, and Persistent Volume Claim are met."
exit 0