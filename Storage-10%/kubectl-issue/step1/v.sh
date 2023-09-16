#!/bin/bash

# Check if `kubectl get node` works fine
if kubectl get node; then
  echo "kubectl get node command works fine."
else
  echo "Error: kubectl get node command failed."
  exit 1
fi

# Validation successful
echo "Validation successful."