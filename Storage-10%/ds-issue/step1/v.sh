#!/bin/bash

# DaemonSet name
DAEMONSET_NAME="cache-daemonset"

# Get the list of nodes
NODES=$(kubectl get nodes -o custom-columns=NAME:.metadata.name --no-headers)

# Initialize a flag to check if pods are present on all nodes
PODS_ON_ALL_NODES=true

# Iterate over each node
for NODE in $NODES; do
    # Check if a pod from the DaemonSet is running on the node
    POD_EXISTS=$(kubectl get pods --field-selector spec.nodeName="$NODE" -l app=cache -o custom-columns=:.metadata.name --no-headers)
    
    # If there are no pods on the node, set the flag to false
    if [ -z "$POD_EXISTS" ]; then
        PODS_ON_ALL_NODES=false
        echo "No pods from DaemonSet found on node: $NODE"
    fi
done

# Check the flag to determine if pods are on all nodes
if [ "$PODS_ON_ALL_NODES" = true ]; then
    echo "DaemonSet '$DAEMONSET_NAME' has created pods on all nodes, including control plane node."
else
    echo "DaemonSet '$DAEMONSET_NAME' has not created pods on all nodes, including control plane node."
    exit 1
fi
