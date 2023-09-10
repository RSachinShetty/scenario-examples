#!/bin/bash

# Check if the Ubuntu pod exists
if kubectl get pod ubuntu-pod &> /dev/null; then
    echo "Validation PASSED: Ubuntu pod 'ubuntu-pod' exists."
else
    echo "Validation FAILED: Ubuntu pod 'ubuntu-pod' does not exist."
    exit 1
fi

# Check if the Ubuntu pod has the 'app=os' label
if kubectl get pod ubuntu-pod --template='{{.metadata.labels.app}}' | grep -q 'os'; then
    echo "Validation PASSED: Ubuntu pod 'ubuntu-pod' has the 'app=os' label."
else
    echo "Validation FAILED: Ubuntu pod 'ubuntu-pod' does not have the 'app=os' label."
    exit 1
fi

# Check if the Ubuntu service exists
if kubectl get svc ubuntu-service &> /dev/null; then
    echo "Validation PASSED: Ubuntu service 'ubuntu-service' exists."
else
    echo "Validation FAILED: Ubuntu service 'ubuntu-service' does not exist."
    exit 1
fi

# Check if the Ubuntu service is of type ClusterIP
if kubectl get svc ubuntu-service -o jsonpath='{.spec.type}' | grep -q 'ClusterIP'; then
    echo "Validation PASSED: Ubuntu service 'ubuntu-service' is of type ClusterIP."
else
    echo "Validation FAILED: Ubuntu service 'ubuntu-service' is not of type ClusterIP."
    exit 1
fi

echo "Validation PASSED: All checks passed."
