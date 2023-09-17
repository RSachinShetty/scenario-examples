#!/bin/bash

# Check if the ConfigMap exists
if kubectl get configmap webapp-deployment-config-map; then
    echo "Validation PASSED: ConfigMap webapp-deployment-config-map exists."
else
    echo "Validation FAILED: ConfigMap webapp-deployment-config-map does not exist."
    exit 1
fi

# Check if the ConfigMap has the expected key-value pair
app_name=$(kubectl get configmap webapp-deployment-config-map -o=jsonpath='{.data.APPLICATION}')
if [ "$app_name" = "web-app" ]; then
    echo "Validation PASSED: ConfigMap webapp-deployment-config-map has the expected key-value pair."
else
    echo "Validation FAILED: ConfigMap webapp-deployment-config-map does not have the expected key-value pair."
    exit 1
fi

# Check if the Deployment exists
if kubectl get deployment webapp-deployment; then
    echo "Validation PASSED: Deployment webapp-deployment exists."
else
    echo "Validation FAILED: Deployment webapp-deployment does not exist."
    exit 1
fi

# Check if the Deployment uses the ConfigMap for the APPLICATION environment variable
env_value=$(kubectl get deployment webapp-deployment -o=jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="APPLICATION")].valueFrom.configMapKeyRef.name}')
if [ "$env_value" = "webapp-deployment-config-map" ]; then
    echo "Validation PASSED: Deployment webapp-deployment uses the ConfigMap for the APPLICATION environment variable."
else
    echo "Validation FAILED: Deployment webapp-deployment does not use the ConfigMap for the APPLICATION environment variable."
    exit 1
fi

# Check if the pods are running
if kubectl get pods -l app=webapp-deployment | grep Running; then
    echo "Validation PASSED: Pods for webapp-deployment are running."
else
    echo "Validation FAILED: Pods for webapp-deployment are not running."
    exit 1
fi

echo "Validation PASSED"
