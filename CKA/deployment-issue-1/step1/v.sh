#!/bin/bash

# Define the deployment name and namespace
DEPLOYMENT_NAME="nginx-deployment"
NAMESPACE="default"

# Fetch the pod name from the deployment
POD_NAME=$(kubectl get pods -n "$NAMESPACE" -l app=nginx -o jsonpath='{.items[0].metadata.name}')

# Check if the pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi

# Check initContainer spec
init_container_name=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.initContainers[0].name}')
if [ "$init_container_name" = "init-container" ]; then
  echo "InitContainer name is correct."
else
  echo "InitContainer name is incorrect."
  exit 1
fi

init_container_image=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.initContainers[0].image}')
if [ "$init_container_image" = "busybox" ]; then
  echo "InitContainer image is correct."
else
  echo "InitContainer image is incorrect."
  exit 1
fi

init_container_command=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.initContainers[0].command[2]}')
if [ "$init_container_command" = "echo 'Welcome To KillerCoda!'" ]; then
  echo "InitContainer command is correct."
else
  echo "InitContainer command is incorrect."
  exit 1
fi

# Check Container spec
container_name=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].name}')
if [ "$container_name" = "nginx-container" ]; then
  echo "Container name is correct."
else
  echo "Container name is incorrect."
  exit 1
fi

container_image=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].image}')
if [ "$container_image" = "nginx:latest" ]; then
  echo "Container image is correct."
else
  echo "Container image is incorrect."
  exit 1
fi

# Check volumeMounts spec
volume_mount_path=$(kubectl describe pod "$POD_NAME" -n "$NAMESPACE" | grep "/etc/nginx/nginx.conf")
if [ -n "$volume_mount_path" ]; then
  echo "VolumeMounts path is correct."
else
  echo "VolumeMounts path is incorrect."
  exit 1
fi

# Check volumes spec
volume_name=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.volumes[0].name}')
if [ "$volume_name" = "nginx-config" ]; then
  echo "Volume name is correct."
else
  echo "Volume name is incorrect."
  exit 1
fi

# Check configMap spec
configmap_name=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.volumes[0].configMap.name}')
if [ "$configmap_name" = "nginx-configmap" ]; then
  echo "ConfigMap name is correct."
else
  echo "ConfigMap name is incorrect."
  exit 1
fi

echo "All specifications are correct."