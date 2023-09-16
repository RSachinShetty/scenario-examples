#!/bin/bash

# Define the filename
filename="/var/lib/kubelet/config.yaml"

old="/etc/kubernetes/pki/ca.crt"
new="/etc/kubernetes/pki/CA.CRT"


# Use sed to replace the old server URL with the new one in the config file
sed -i "s|$old|$new|g" "$filename"

# Check if sed was successful (exit code 0) or not (exit code 1)
if [ $? -eq 0 ]; then
  echo "updated successfully."
else
  echo "Not Updated"
fi