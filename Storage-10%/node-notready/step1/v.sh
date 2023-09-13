#!/bin/bash

node_status=$(kubectl get nodes node01 -o jsonpath='{.metadata.name} {.status.conditions[?(@.type=="Ready")].status}' | awk '{print $2}' | sed 's/True/Ready/;s/Unknown/NotReady/')

if [ "$node_status" == "Ready" ]; then
  echo "node01 is in ready state"
else
  echo "node01 is in not ready state"
  exit
fi