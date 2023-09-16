#!/bin/bash

# Define the old and new server URLs
old_val="- kube-controller-manager"
new_val="- kube-controller-manegaar"

# Specify the path to the config file
controller_file="/etc/kubernetes/manifests/kube-controller-manager.yaml"

# Use sed to replace the old server URL with the new one in the config file
sed -i "s|$old_val|$new_val|g" "$controller_file"

# Check if sed was successful (exit code 0) or not (exit code 1)
if [ $? -eq 0 ]; then
  echo "controller_file  updated successfully."
else
  echo "Error: Failed to update controller_file."
fi


kubectl create deployment video-app --image=redis:7.2.1 --replicas=2