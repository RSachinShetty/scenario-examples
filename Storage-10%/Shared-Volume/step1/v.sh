#!/bin/bash

# Pod Specifications
pod_name="my-pod-cka"
nginx_container_name="nginx-container"
sidecar_name="sidecar-container"
mount_path_main="/var/www/html"
mount_path_sidecar="/var/www/shared"
sidecar_command="sh -c tail -f /dev/null"
sidecar_image="busybox"
read_only_expected="true"

# Verify Pod Specifications
pod_info=$(kubectl get pod "$pod_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: Pod $pod_name not found."
  exit 1
fi

nginx_container_mounts=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[?(@.name == "nginx-container")].volumeMounts[?(@.name == "shared-storage")].mountPath}')
sidecar_container_mounts=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[?(@.name == "sidecar-container")].volumeMounts[?(@.name == "shared-storage")].mountPath}')
sidecar_container_command=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[?(@.name == "sidecar-container")].command[*]}')
sidecar_container_read_only=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[?(@.name == "sidecar-container")].volumeMounts[?(@.name == "shared-storage")].readOnly}')

# Check if the main container and sidecar container have the specified volume mounts, command, and read-only access
if [ "$nginx_container_mounts" == "$mount_path_main" ] && [ "$sidecar_container_mounts" == "$mount_path_sidecar" ] && [ "${sidecar_container_command[@]}" == "${sidecar_command[*]}" ]; then
  echo "Pod $pod_name meets the criteria for volume mounts and command."
  
  # Check if the sidecar container with the specified image exists
  sidecar_image_check=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[?(@.name == "sidecar-container")].image}')
  if [ "$sidecar_image_check" == "$sidecar_image" ]; then
    echo "Sidecar container with image $sidecar_image found."
    
    # Check if the sidecar container has read-only access to the shared volume
    if [ "$sidecar_container_read_only" == "$read_only_expected" ]; then
      echo "Sidecar container has read-only access to the shared volume."
    else
      echo "Error: Sidecar container does not have read-only access to the shared volume."
      exit 1
    fi
    
  else
    echo "Error: Sidecar container with image $sidecar_image not found."
    exit 1
  fi
else
  echo "Error: Pod $pod_name does not meet the criteria for volume mounts and command."
  exit 1
fi

echo "Validation successful!"
