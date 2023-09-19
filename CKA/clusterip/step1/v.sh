#!/bin/bash

# Deployment and Service names
deployment_name="nginx-deployment"
service_name="nginx-service"

# Check if Deployment exists
if kubectl get deployment "$deployment_name" &> /dev/null; then
  echo "Deployment $deployment_name exists."
else
  echo "Deployment $deployment_name does not exist."
  exit 1
fi

# Check if Deployment has 3 replicas
replicas=$(kubectl get deployment "$deployment_name" -o=jsonpath='{.spec.replicas}')
if [ "$replicas" -eq 3 ]; then
  echo "Deployment $deployment_name has 3 replicas."
else
  echo "Deployment $deployment_name does not have 3 replicas (Current: $replicas)."
  exit 1
fi

# Check if Service exists
if kubectl get service "$service_name" &> /dev/null; then
  echo "Service $service_name exists."
else
  echo "Service $service_name does not exist."
  exit 1
fi

# Check if Service type is ClusterIP
service_type=$(kubectl get service "$service_name" -o=jsonpath='{.spec.type}')
if [ "$service_type" = "ClusterIP" ]; then
  echo "Service $service_name is of type ClusterIP."
else
  echo "Service $service_name is not of type ClusterIP (Current: $service_type)."
  exit 1
fi

pod_ips_file="pod_ips.txt"

# Fetch the IP addresses of the pods in the default namespace
pod_ips=$(kubectl get pods -o jsonpath="{.items[*].status.podIP}" | tr ' ' '\n' | sort -n)

# Read the IP addresses from the stored file
stored_ips=$(tail -n +2 "$pod_ips_file" | sort -n)

# Check if the first line of the file is "IP_ADDRESS"
first_line=$(head -n 1 "$pod_ips_file")
if [ "$first_line" = "IP_ADDRESS" ]; then
  echo "Validation PASSED: First line of $pod_ips_file is 'IP_ADDRESS'."
else
  echo "Validation FAILED: First line of $pod_ips_file is not 'IP_ADDRESS'."
  exit 1
fi

# Compare the fetched IPs with the stored IPs
if [ "$pod_ips" = "$stored_ips" ]; then
    echo "Validation PASSED: IP addresses match the stored IPs."
    exit 0
else
    echo "Validation FAILED: IP addresses do not match the stored IPs."
    exit 1
fi