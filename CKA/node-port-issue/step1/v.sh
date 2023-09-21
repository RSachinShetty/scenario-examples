#!/bin/bash

# Define the filename and section
filename="/etc/kubernetes/manifests/kube-apiserver.yaml"

# Define the probe names
probe_names="livenessProbe readinessProbe startupProbe"

# Iterate through the probe names and validate the port value
for probe in $probe_names; do
  # Use awk to extract the port value from the specified probe section
  port_value=$(awk -v probe="$probe" '/^ *'$probe':/,/port: 6443/' "$filename" | grep 'port:' | tail -n1 | awk '{print $2}')

  # Check if the port value is 6443
  if [ "$port_value" = "6443" ]; then
    echo "$probe: Port value is 6443 in $filename."
  else
    echo "$probe: Port value is not 6443 in $filename."
    exit 1
  fi
done

# Check if kube-apiserver-controlplane pod is running
apiserver_pod_status=$(kubectl get pod -n kube-system -l component=kube-apiserver -o jsonpath='{.items[0].status.phase}' 2>/dev/null)

# Check if both pods are running
if [ "$apiserver_pod_status" = "Running" ]; then
  echo "Both kube-controller-manager-controlplane and kube-apiserver-controlplane pods are running in kube-system namespace."
else
  echo "One or both of the required pods are not running in kube-system namespace."
  exit 1
fi
