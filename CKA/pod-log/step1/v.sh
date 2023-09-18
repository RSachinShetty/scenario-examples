#!/bin/bash

# Validate Kubernetes Pod configuration
# This script assumes that `kubectl` is configured properly.

# Specify the Pod name
POD_NAME="alpine-pod-pod"

# Check if the Pod exists
if kubectl get pod "$POD_NAME" &> /dev/null; then
  echo "Pod $POD_NAME exists."
else
  echo "Error: Pod $POD_NAME not found."
  exit 1
fi

# Validate container image
CONTAINER_IMAGE="alpine:latest"
CONTAINER_NAME="alpine-container"

CURRENT_IMAGE=$(kubectl get pod "$POD_NAME" -o jsonpath="{.spec.containers[?(@.name=='$CONTAINER_NAME')].image}")
if [ "$CURRENT_IMAGE" = "$CONTAINER_IMAGE" ]; then
  echo "Container image is set to $CONTAINER_IMAGE."
else
  echo "Error: Container image is not set to $CONTAINER_IMAGE."
  exit 1
fi

# Check the command and args
EXPECTED_COMMAND="/bin/sh"
EXPECTED_ARGS="tail -f /config/log.txt"

CURRENT_COMMAND=$(kubectl get pod "$POD_NAME" -o jsonpath="{.spec.containers[?(@.name=='$CONTAINER_NAME')].command[0]}")
CURRENT_ARGS=$(kubectl get pod "$POD_NAME" -o jsonpath="{.spec.containers[?(@.name=='$CONTAINER_NAME')].args[0]}")

if [ "$CURRENT_COMMAND" = "$EXPECTED_COMMAND" ] && [ "$CURRENT_ARGS" = "$EXPECTED_ARGS" ]; then
  echo "Command and args are correctly set."
else
  echo "Error: Command and args are not correctly set."
  exit 1
fi

# Check volume and ConfigMap
VOLUME_NAME="config-volume"
CONFIG_MAP_NAME="log-configmap"

CURRENT_VOLUMES=$(kubectl get pod "$POD_NAME" -o jsonpath="{.spec.volumes[?(@.name == 'config-volume')].name}")
CURRENT_CONFIG_MAP=$(kubectl get pod "$POD_NAME" -o jsonpath="{.spec.volumes[?(@.name=='$VOLUME_NAME')].configMap.name}")

if [ "$CURRENT_VOLUMES" = "$VOLUME_NAME" ] && [ "$CURRENT_CONFIG_MAP" = "$CONFIG_MAP_NAME" ]; then
  echo "Volume and ConfigMap are correctly set."
else
  echo "Error: Volume and ConfigMap are not correctly set."
  exit 1
fi

# Check restart policy
RESTART_POLICY="Never"

CURRENT_RESTART_POLICY=$(kubectl get pod "$POD_NAME" -o jsonpath="{.spec.restartPolicy}")

if [ "$CURRENT_RESTART_POLICY" = "$RESTART_POLICY" ]; then
  echo "Restart policy is set to $RESTART_POLICY."
else
  echo "Error: Restart policy is not set to $RESTART_POLICY."
  exit 1
fi

# Check if the pod is running
pod_status=$(kubectl get pod "$POD_NAME" -o=jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
    echo "Validation PASSED: Pod my-pod is running."
else
    echo "Validation FAILED: Pod my-pod is not running."
    exit 1
fi

# Validation successful
echo "Validation passed for Pod $POD_NAME."
