#!/bin/bash

# Namespace and deployment name
namespace="nginx-app-space"
deployment_name="nginx-app-cka"

# Verify the Service Configuration
kubectl get svc -n $namespace nginx-service-cka -o jsonpath="{.spec.ports[0].port}" | grep -q 8080
if [ $? -eq 0 ]; then
    echo "Service exposed on port 8080"
else
    echo "Service not exposed on port 8080"
    exit 1  # Exit with a non-zero status code to indicate failure
fi

# Verify the Service Type
kubectl get svc -n $namespace nginx-service-cka -o jsonpath="{.spec.type}" | grep -q NodePort
if [ $? -eq 0 ]; then
    echo "Service type is NodePort"
else
    echo "Service type is not NodePort"
    exit 1
fi

# Verify the Service Name
kubectl get svc -n $namespace nginx-service-cka -o jsonpath="{.metadata.name}" | grep -q nginx-service-cka
if [ $? -eq 0 ]; then
    echo "Service name is nginx-service-cka"
else
    echo "Service name is not nginx-service-cka"
    exit 1
fi

# Verify the Service Selector
kubectl get svc -n $namespace nginx-service-cka -o jsonpath="{.spec.selector.app}" | grep -q nginx-app-cka
if [ $? -eq 0 ]; then
    echo "Service selector matches deployment app label"
else
    echo "Service selector does not match deployment app label"
    exit 1
fi

# If all checks pass, exit with a success status code
exit 0
