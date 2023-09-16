#!/bin/bash

# Storage Class
sc_name="fast-storage"

# PV
pv_name="fast-pv-cka"

# PVC
pvc_name="fast-pvc-cka"

# Pod
pod_name="fast-pod-cka"

# Verify Storage Class
sc_info=$(kubectl get sc "$sc_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: Storage Class $sc_name not found."
  exit 1
fi

sc_provisioner=$(kubectl get sc "$sc_name" -o=jsonpath='{.provisioner}')
sc_volume_binding_mode=$(kubectl get sc "$sc_name" -o=jsonpath='{.volumeBindingMode}')

if [ "$sc_provisioner" == "kubernetes.io/no-provisioner" ] && [ "$sc_volume_binding_mode" == "Immediate" ]; then
  echo "Storage Class $sc_name meets the criteria."
else
  echo "Error: Storage Class $sc_name does not meet the criteria."
  exit 1
fi

# Verify PV
pv_info=$(kubectl get pv "$pv_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: PV $pv_name not found."
  exit 1
fi

pv_capacity=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.capacity.storage}')
pv_storage_class=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.storageClassName}')

if [ "$pv_capacity" == "50Mi" ] && [ "$pv_storage_class" == "$sc_name" ]; then
  echo "PV $pv_name meets the criteria."
else
  echo "Error: PV $pv_name does not meet the criteria."
  exit 1
fi

# Verify PVC
pvc_info=$(kubectl get pvc "$pvc_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: PVC $pvc_name not found."
  exit 1
fi

pvc_access_modes=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.accessModes[0]}')
pvc_storage_class=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.storageClassName}')
pvc_storage_requests=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')

if [ "$pvc_access_modes" == "ReadWriteOnce" ] && [ "$pvc_storage_class" == "$sc_name" ] && [ "$pvc_storage_requests" == "30Mi" ]; then
  echo "PVC $pvc_name meets the criteria."
else
  echo "Error: PVC $pvc_name does not meet the criteria."
  exit 1
fi

# Verify Pod and Check Status
pod_info=$(kubectl get pod "$pod_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: Pod $pod_name not found."
  exit 1
fi

pod_status=$(kubectl get pod "$pod_name" -o=jsonpath='{.status.phase}')

if [ "$pod_status" == "Running" ]; then
  echo "Pod $pod_name is running."
else
  echo "Error: Pod $pod_name is not running."
  exit 1
fi

echo "Validation successful!"