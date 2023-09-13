#!/bin/bash

# Check the status of kubelet.service
kubelet_status=$(systemctl is-active kubelet.service)

if [ "$kubelet_status" == "active" ]; then
  echo "kubelet.service is running."
else
  echo "kubelet.service is not running."
  exit 1
fi
