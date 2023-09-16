#!/bin/bash

# Define the filename
filename="/etc/kubernetes/manifests/kube-apiserver.yaml"

# Use sed to replace the port number
sed -i 's/port: 6443/port: 6433/g' "$filename"

echo "Port updated from 6443 to 6433 in $filename."
