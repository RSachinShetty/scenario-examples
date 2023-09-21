#!/bin/bash

# Define the filename
filename="/var/lib/kubelet/config.yaml"
filename1="/etc/kubernetes/kubelet.conf"

old="/etc/kubernetes/pki/ca.crt"
new="/etc/kubernetes/pki/CA.CERTIFICATE"

old1="https://172.30.1.2:6443"
new1="https://172.30.1.2:64433333"


# Use sed to replace the old server URL with the new one in the config file
sed -i "s|$old|$new|g" "$filename"
# Check if sed was successful (exit code 0) or not (exit code 1)
if [ $? -eq 0 ]; then
  echo "updated successfully."
else
  echo "Not Updated"
fi


sed -i "s|$old1|$new1|g" "$filename1"
# Check if sed was successful (exit code 0) or not (exit code 1)
if [ $? -eq 0 ]; then
  echo "1 updated successfully."
else
  echo "1 Not Updated"
fi

systemctl daemon-reload
systemctl restart kubelet
