#!/bin/bash

# PVC Name
pvc_name="nginx-pvc-cka"

# Pod Name
pod_name="nginx-pod-cka"

# Verify PVC
pvc_info=$(kubectl get pvc "$pvc_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: PVC $pvc_name not found."
  exit 1
fi

pvc_access_modes=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.accessModes[0]}')
pvc_storage=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')

if [ "$pvc_access_modes" == "ReadWriteOnce" ] && [ "$pvc_storage" == "80Mi" ]; then
  echo "PVC $pvc_name meets the criteria."
else
  echo "Error: PVC $pvc_name does not meet the criteria."
  exit 1
fi

# Verify Pod
pod_info=$(kubectl get pod "$pod_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: Pod $pod_name not found."
  exit 1
fi

pod_volumes=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.volumes[0].persistentVolumeClaim.claimName}')
pod_mount_path=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[0].volumeMounts[0].mountPath}')

if [ "$pod_volumes" == "$pvc_name" ] && [ "$pod_mount_path" == "/var/www/html" ]; then
  echo "Pod $pod_name meets the criteria."
else
  echo "Error: Pod $pod_name does not meet the criteria."
  exit 1
fi

echo "Validation successful!"