#!/bin/bash

# Verify PVC
pvc_name="red-pvc-cka"
expected_volume_name="red-pv-cka"
expected_storage_class="manual"
expected_access_mode="ReadWriteOnce"
expected_storage_request="30Mi"

# Check if PVC exists
if kubectl get pvc "$pvc_name" &> /dev/null; then
  echo "PVC $pvc_name exists."

  # Get PVC details
  pvc_info=$(kubectl get pvc "$pvc_name" -o json)

  # Verify volumeName
  actual_volume_name=$(echo "$pvc_info" | jq -r '.spec.volumeName')
  if [ "$actual_volume_name" == "$expected_volume_name" ]; then
    echo "VolumeName is correct: $actual_volume_name"
  else
    echo "Error: VolumeName is not correct. Expected: $expected_volume_name, Actual: $actual_volume_name"
    exit 1
  fi

  # Verify storageClassName
  actual_storage_class=$(echo "$pvc_info" | jq -r '.spec.storageClassName')
  if [ "$actual_storage_class" == "$expected_storage_class" ]; then
    echo "StorageClassName is correct: $actual_storage_class"
  else
    echo "Error: StorageClassName is not correct. Expected: $expected_storage_class, Actual: $actual_storage_class"
    exit 1
  fi

  # Verify accessModes
  actual_access_modes=$(echo "$pvc_info" | jq -r '.spec.accessModes[]')
  if [[ "$actual_access_modes" == *"$expected_access_mode"* ]]; then
    echo "AccessModes are correct: $actual_access_modes"
  else
    echo "Error: AccessModes are not correct. Expected: $expected_access_mode, Actual: $actual_access_modes"
    exit 1
  fi

  # Verify resources.requests.storage
  actual_storage_request=$(echo "$pvc_info" | jq -r '.spec.resources.requests.storage')
  if [ "$actual_storage_request" == "$expected_storage_request" ]; then
    echo "Storage request is correct: $actual_storage_request"
  else
    echo "Error: Storage request is not correct. Expected: $expected_storage_request, Actual: $actual_storage_request"
    exit 1
  fi

else
  echo "Error: PVC $pvc_name does not exist."
  exit 1
fi

exit 0