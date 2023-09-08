#!/bin/bash

# PVC Specifications
pvc_name="pink-pvc-cka"
requested_storage="100Mi"

# Deployment Specifications
deployment_name="pink-app-cka"
container_name="nginx-container"
sidecar_name="sidecar-container"
mount_path_main="/var/www/html"
mount_path_sidecar="/var/www/shared"
sidecar_command="tail -f /dev/null"

# Verify PVC Specifications
pvc_info=$(kubectl get pvc "$pvc_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: PVC $pvc_name not found."
  exit 1
fi

pvc_access_modes=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.accessModes[0]}')
pvc_storage=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.resources.requests.storage}')

if [ "$pvc_access_modes" == "ReadWriteOnce" ] && [ "$pvc_storage" == "$requested_storage" ]; then
  echo "PVC $pvc_name meets the criteria."
else
  echo "Error: PVC $pvc_name does not meet the criteria."
  exit 1
fi

# Verify Deployment Specifications
deployment_info=$(kubectl get deployment "$deployment_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: Deployment $deployment_name not found."
  exit 1
fi

main_container_mounts=$(kubectl get deployment "$deployment_name" -o=jsonpath='{.spec.template.spec.containers[?(@.name == "'"$container_name"'")].volumeMounts[*].mountPath}')
sidecar_container_mounts=$(kubectl get deployment "$deployment_name" -o=jsonpath='{.spec.template.spec.containers[?(@.name == "'"$sidecar_name"'")].volumeMounts[*].mountPath}')
sidecar_container_command=$(kubectl get deployment "$deployment_name" -o=jsonpath='{.spec.template.spec.containers[?(@.name == "'"$sidecar_name"'")].command[*]}')

if [ "$main_container_mounts" == "$mount_path_main" ] && [ "$sidecar_container_mounts" == "$mount_path_sidecar" ] && [ "$sidecar_container_command" == "${sidecar_command}" ]; then
  echo "Deployment $deployment_name meets the criteria."
else
  echo "Error: Deployment $deployment_name does not meet the criteria."
  exit 1
fi

echo "Validation successful!"
