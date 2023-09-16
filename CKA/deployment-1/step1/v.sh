#!/bin/bash

# Function to check if a resource is less than or equal to another resource
compare_resources() {
  local resource1="$1"
  local resource2="$2"

  # Remove any prefixes like "Mi" or "m" and convert to numeric values
  resource1_numeric=$(echo "$resource1" | sed 's/[^0-9.]//g')
  resource2_numeric=$(echo "$resource2" | sed 's/[^0-9.]//g')

  # Compare numeric values
  if [ "$(echo "$resource1_numeric <= $resource2_numeric" | bc)" -eq 1 ]; then
    echo "true"
  else
    echo "false"
  fi
}

# Check if the Deployment exists
if kubectl get deployment my-app-deployment &> /dev/null; then
    echo "Validation PASSED: Deployment my-app-deployment exists."
else
    echo "Validation FAILED: Deployment my-app-deployment does not exist."
    exit 1
fi

# Check if the desired replica count is 2
desired_replicas=$(kubectl get deployment my-app-deployment -o=jsonpath='{.spec.replicas}')
if [ "$desired_replicas" -eq 2 ]; then
    echo "Validation PASSED: Desired replica count is 2."
else
    echo "Validation FAILED: Desired replica count is not 2, it is $desired_replicas."
    exit 1
fi

# Check the number of running pods
running_pods=$(kubectl get pods -l app=my-app -o=jsonpath='{.items[*].status.phase}' | tr ' ' '\n' | grep -c Running)
if [ "$running_pods" -eq 2 ]; then
    echo "Validation PASSED: Two pods of my-app are running."
else
    echo "Validation FAILED: Expected 2 pods of my-app to be running, but found $running_pods."
    exit 1
fi

# Check if the image is nginx:latest
image=$(kubectl get deployment my-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image" == "nginx:latest" ]; then
    echo "Validation PASSED: Image is nginx:latest."
else
    echo "Validation FAILED: Image is not nginx:latest, it is $image."
    exit 1
fi

# Check if resource requests are less than resource limits
requests_memory=$(kubectl get deployment my-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].resources.requests.memory}')
limits_memory=$(kubectl get deployment my-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}')
requests_cpu=$(kubectl get deployment my-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}')
limits_cpu=$(kubectl get deployment my-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].resources.limits.cpu}')

if compare_resources "$requests_memory" "$limits_memory" && compare_resources "$requests_cpu" "$limits_cpu"; then
    echo "Validation PASSED: Resource requests are less than resource limits."
else
    echo "Validation FAILED: Resource requests are greater than or equal to resource limits."
    exit 1
fi

echo "Validation PASSED"
