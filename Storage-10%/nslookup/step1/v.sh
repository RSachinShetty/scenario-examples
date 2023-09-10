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
kubectl run test-nslookup --image=busybox --rm -it --restart=Never -- nslookup dns-service-cka.default.svc.cluster.local > dns-service-test.txt

# Extract the relevant lines from dns-service-test.txt and dns-service.txt
grep -E 'Server:|Address:|Name:' dns-service-test.txt > dns-service-test-extracted.txt
grep -E 'Server:|Address:|Name:' dns-service.txt > dns-service-extracted.txt

# Compare the two extracted files
if diff -q dns-service-test-extracted.txt dns-service-extracted.txt &> /dev/null; then
    echo "Validation PASSED: DNS resolution matches expected output."
else
    echo "Validation FAILED: DNS resolution does not match expected output."
    exit 1
fi

IP=$(kubectl get pod dns-pod-cka -o wide --no-headers | awk '{print $6}' | tr '.' '-')

# Perform nslookup for dns-pod-cka and store the output in dns-pod-test.txt
kubectl run test-nslookup-pod --image=busybox --rm -it --restart=Never -- nslookup $IP.default.pod > dns-pod-test.txt

# Perform nslookup for dns-service-cka and store the output in dns-service-test.txt
kubectl run test-nslookup-service --image=busybox --rm -it --restart=Never -- nslookup dns-service-cka.default.svc.cluster.local > dns-service-test.txt

# Extract relevant lines from the test outputs
grep -E 'Server:|Address:|Name:' dns-pod-test.txt > dns-pod-test-extracted.txt
grep -E 'Server:|Address:|Name:' dns-pod.txt > dns-pod-extracted.txt
grep -E 'Server:|Address:|Name:' dns-service-test.txt > dns-service-test-extracted.txt
grep -E 'Server:|Address:|Name:' dns-service.txt > dns-service-extracted.txt

# Compare the extracted files
if diff -q dns-pod-test-extracted.txt dns-pod-extracted.txt &> /dev/null && \
   diff -q dns-service-test-extracted.txt dns-service-extracted.txt &> /dev/null; then
    echo "Validation PASSED: DNS resolution matches expected output for both pod and service."
else
    echo "Validation FAILED: DNS resolution does not match expected output for either pod or service."
    exit 1
fi

# Clean up temporary files
rm -f dns-pod-test.txt dns-pod-test-extracted.txt dns-service-test.txt dns-service-test-extracted.txt