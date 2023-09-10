#!/bin/bash

# Check if dns-pod-cka exists
if kubectl get pod dns-pod-cka &> /dev/null; then
    echo "Validation PASSED: dns-pod-cka exists."
else
    echo "Validation FAILED: dns-pod-cka does not exist."
    exit 1
fi

# Check if dns-service-cka service of type ClusterIP exists
if kubectl get svc dns-service-cka -o jsonpath='{.spec.type}' | grep -q 'ClusterIP'; then
    echo "Validation PASSED: dns-service-cka of type ClusterIP exists."
else
    echo "Validation FAILED: dns-service-cka of type ClusterIP does not exist."
    exit 1
fi

# Perform nslookup for dns-service-cka and store the output in dns-service-test.txt
kubectl run test-nslookup-service --image=busybox --rm -it --restart=Never -- nslookup dns-service-cka.default.svc.cluster.local > dns-service-test.txt

# Extract relevant lines from the test outputs
grep -E 'Server:|Address:|Name:' dns-service-test.txt > dns-service-test-extracted.txt
grep -E 'Server:|Address:|Name:' nginx-service.txt > nginx-service-extracted.txt

# Compare the extracted files
if diff -q dns-service-test-extracted.txt nginx-service-extracted.txt &> /dev/null; then
    echo "Validation PASSED: DNS resolution matches expected output for both pod and service."
else
    echo "Validation FAILED: DNS resolution does not match expected output for either pod or service."
    exit 1
fi

# Clean up temporary files
rm -f dns-service-test.txt dns-service-test-extracted.txt
