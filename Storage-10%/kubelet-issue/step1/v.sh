#!/bin/bash

# Specify the file path and the content to search for (case-insensitive)
FILE_PATH="/var/lib/kubelet/config.yaml"
FILE_PATH1="/etc/kubernetes/kubelet.conf"

EXPECTED_CONTENT="/etc/kubernetes/pki/ca.crt"
EXPECTED_CONTENT1="https://172.30.1.2:6443"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
  echo "File '$FILE_PATH' does not exist."
  exit 1
fi

# Check if the file exists
if [ ! -f "$FILE_PATH1" ]; then
  echo "File '$FILE_PATH1' does not exist."
  exit 1
fi

# Perform a case-insensitive search for the content
if grep -q -i "$EXPECTED_CONTENT" "$FILE_PATH"; then
  echo "File '$FILE_PATH' contains the expected content '$EXPECTED_CONTENT' (case-insensitive)."
  exit 0
else
  echo "File '$FILE_PATH' does not contain the expected content '$EXPECTED_CONTENT' (case-insensitive)."
  exit 1
fi

# Perform a case-insensitive search for the content
if grep -q -i "$EXPECTED_CONTENT1" "$FILE_PATH1"; then
  echo "File '$FILE_PATH1' contains the expected content '$EXPECTED_CONTENT1' (case-insensitive)."
  exit 0
else
  echo "File '$FILE_PATH1' does not contain the expected content '$EXPECTED_CONTENT1' (case-insensitive)."
  exit 1
fi

# Check the status of kubelet.service
kubelet_status=$(systemctl is-active kubelet.service)

if [ "$kubelet_status" == "active" ]; then
  echo "kubelet.service is running."
else
  echo "kubelet.service is not running."
  exit 1
fi
