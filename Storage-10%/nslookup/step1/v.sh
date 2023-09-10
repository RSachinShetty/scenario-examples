#!/bin/bash

# Function to compare two files
compare_files() {
    local file1="$1"
    local file2="$2"
    if cmp -s "$file1" "$file2"; then
        echo "Validation PASSED: DNS resolution matches expected output."
    else
        echo "Validation FAILED: DNS resolution does not match expected output."
        exit 1
    fi
}

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
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-service-cka > "nginx-service-test.txt"

#compare_files "nginx-service-extracted.txt"
compare_files "nginx-service.txt" "nginx-service-test.txt"

# Clean up temporary files
rm -f nginx-service-test.txt

