#!/bin/bash

# Define the name of the StorageClass
storage_class_name="orange-stc-cka07-str"

# Verify if the StorageClass exists
if kubectl get storageclass ${storage_class_name} &> /dev/null; then
  # StorageClass exists, check its properties
  provisioner=$(kubectl get storageclass ${storage_class_name} -o=jsonpath='{.provisioner}')
  binding_mode=$(kubectl get storageclass ${storage_class_name} -o=jsonpath='{.volumeBindingMode}')

  # Check if the properties match the expected values
  if [ "$provisioner" == "kubernetes.io/no-provisioner" ] && [ "$binding_mode" == "WaitForFirstConsumer" ]; then
    echo "StorageClass '${storage_class_name}' exists and meets the criteria."
    exit 0
  else
    echo "Error: StorageClass '${storage_class_name}' exists but does not meet the criteria."
    exit 1
  fi
else
  # StorageClass doesn't exist
  echo "Error: StorageClass '${storage_class_name}' does not exist."
  exit 1
fi
