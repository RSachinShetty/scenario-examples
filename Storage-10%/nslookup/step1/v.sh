#!/bin/bash

# Check if nginx-pod-cka exists
if kubectl get pod nginx-pod-cka &> /dev/null; then
    echo "Validation PASSED: nginx-pod-cka exists."
else
    echo "Validation FAILED: nginx-pod-cka does not exist."
    exit 1
fi

# Check if nginx-service-cka service of type ClusterIP exists
if kubectl get svc nginx-service-cka -o jsonpath='{.spec.type}' | grep -q 'ClusterIP'; then
    echo "Validation PASSED: nginx-service-cka of type ClusterIP exists."
else
    echo "Validation FAILED: nginx-service-cka of type ClusterIP does not exist."
    exit 1
fi

# Perform nslookup for nginx-service-cka and store the output in nginx-service-test.txt
kubectl run test-nslookup-service --image=busybox --rm -it --restart=Never -- nslookup nginx-service-cka.default.svc.cluster.local > nginx-service-test.txt

# Extract relevant lines from the test outputs
grep -E 'Server:|Address:|Name:' nginx-service-test.txt > nginx-service-test-extracted.txt
grep -E 'Server:|Address:|Name:' nginx-service.txt > nginx-service-extracted.txt

# Compare the extracted files
if diff -q nginx-service-test-extracted.txt nginx-service-extracted.txt &> /dev/null; then
    echo "Validation PASSED: DNS resolution matches expected output for both pod and service."
else
    echo "Validation FAILED: DNS resolution does not match expected output for either pod or service."
    exit 1
fi

# Clean up temporary files
rm -f nginx-service-test.txt nginx-service-test-extracted.txt
