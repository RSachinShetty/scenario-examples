#!/bin/bash

# Check the contents of nginx-service.txt
service_dns_server=$(cat nginx-service.txt | grep "Server:")
service_dns_address=$(cat nginx-service.txt | grep "Address:")

# Check the contents of nginx-pod.txt
pod_dns_server=$(cat nginx-pod.txt | grep "Server:")
pod_dns_address=$(cat nginx-pod.txt | grep "Address:")

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

# Validate DNS resolution results
if [ -n "$service_dns_server" ] && [ -n "$service_dns_address" ] && [ -n "$pod_dns_server" ] && [ -n "$pod_dns_address" ]; then
    echo "Validation PASSED: DNS resolution for nginx-service-cka and nginx-pod-cka is successful."
else
    echo "Validation FAILED: DNS resolution did not produce the expected results."
    exit 1
fi

# Perform nslookup for nginx-service-cka
kubectl run test-nslookup-service --image=busybox --rm -it --restart=Never -- nslookup nginx-service-cka > nginx-service-test.txt

# Get IP of nginx-pod-cka
IP=$(kubectl get pod nginx-pod-cka -o jsonpath='{.status.podIP}')

# Perform nslookup for nginx-pod-cka
kubectl run test-nslookup-pod --image=busybox --rm -it --restart=Never -- nslookup $IP.default.pod > nginx-pod-test.txt

# Extract the first two lines of each file
head -n 2 nginx-service-test.txt > nginx-service-test-head.txt
head -n 2 nginx-pod-test.txt > nginx-pod-test-head.txt
head -n 2 nginx-service.txt > nginx-service-head.txt
head -n 2 nginx-pod.txt > nginx-pod-head.txt

# Compare the first two lines
if cmp -s nginx-service-test-head.txt nginx-service-head.txt; then
    echo "Validation PASSED: Service IP matches the stored IP."
else
    echo "Validation FAILED: Service IP does not match the stored IP."
    exit 1
fi

if cmp -s nginx-pod-test-head.txt nginx-pod-head.txt; then
    echo "Validation PASSED: Pod IP matches the stored IP."
else
    echo "Validation FAILED: Pod IP does not match the stored IP."
    exit 1
fi

# Clean up temporary files
rm -f nginx-service-test-head.txt nginx-pod-test-head.txt nginx-service-head.txt nginx-pod-head.txt
