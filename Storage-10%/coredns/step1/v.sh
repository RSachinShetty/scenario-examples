#!/bin/bash

flag="false"
# Check if the ReplicaSet exists
if kubectl get rs dns-rs-cka -n dns-ns &> /dev/null; then
    echo "Validation PASSED: ReplicaSet dns-rs-cka exists."
else
    echo "Validation FAILED: ReplicaSet dns-rs-cka does not exist."
    flag="true"
fi  

# Check if there are exactly 2 replicas
replica_count=$(kubectl get rs dns-rs-cka -n dns-ns -o=jsonpath='{.status.replicas}')
if [ "$replica_count" -eq 2 ]; then
    echo "Validation PASSED: ReplicaSet dns-rs-cka has 2 replicas."
else
    echo "Validation FAILED: ReplicaSet dns-rs-cka does not have 2 replicas."
    flag="true"
fi

# Check if the container name is dns-container
POD_NAME=$(kubectl get pods -n dns-ns -o jsonpath='{.items[0].metadata.name}')

container_name=$(kubectl get pod -n dns-ns $POD_NAME -o=jsonpath='{.spec.containers[0].name}')
# Check if the container name matches "dns-container"
if [ "$container_name" = "dns-container" ]; then
    echo "Validation PASSED: Container name in dns-rs-cka is dns-container."
else
    echo "Validation FAILED: Container name in dns-rs-cka is not dns-container."
    flag="true"
fi

# Check if the image used is registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3
image_name=$(kubectl get pod -n dns-ns -o=jsonpath='{.items[0].spec.containers[0].image}')
if [ "$image_name" = "registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3" ]; then
    echo "Validation PASSED: Container image in dns-rs-cka is correct."
else
    echo "Validation FAILED: Container image in dns-rs-cka is incorrect."
    flag="true"
fi

# Check if the command is set to 'sleep 3600'
command=$(kubectl get pod -n dns-ns -o=jsonpath='{.items[0].spec.containers[0].command[0]}')
if [ "$command" = "sleep" ]; then
    echo "Validation PASSED: Command in dns-rs-cka is set to 'sleep 3600'."
else
    echo "Validation FAILED: Command in dns-rs-cka is not set to 'sleep 3600'."
    flag="true"
fi

compare_files() {
    local file1="$1"
    local file2="$2"
    if cmp -s "$file1" "$file2"; then
        echo "Validation PASSED: DNS resolution matches expected output."
    else
        echo "Validation FAILED: DNS resolution does not match expected output."
        flag="true"
    fi
}

kubectl exec -n dns-ns -i -t $POD_NAME -- nslookup kubernetes.default > dns-pod-test.txt

compare_files "dns-output.txt" "dns-pod-test.txt"

#rm -f dns-pod-test.txt #dns-pod-test-extracted.txt

if [ "$flag" = "true" ]; then
    exit 1
fi

echo "Validation PASSED"
