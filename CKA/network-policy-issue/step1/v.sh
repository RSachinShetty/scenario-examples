#!/bin/bash

# Define pod names and network policy name
BLUE_POD="blue-pod"
RED_POD="red-pod"
NETWORK_POLICY="allow-green-and-blue"

# Fetch the NetworkPolicy rules
network_policy_rules=$(kubectl get networkpolicy "$NETWORK_POLICY" -o jsonpath='{.spec.ingress[*].from[?(@.podSelector.matchLabels.run=="blue-pod")]}')

# Check if network policy rules deny traffic from blue-pod to red-pod
if [ -z "$network_policy_rules" ]; then
  echo "NetworkPolicy does not allow blue-pod to access red-pod."
else
  echo "NetworkPolicy allows blue-pod to access red-pod."
  exit 1
fi
