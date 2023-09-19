#!/bin/bash

# Service Name and Namespace
service_name="app-service-cka"
namespace="nginx-app-space"

# Validate Service Name
if kubectl get svc "$service_name" -n "$namespace" &> /dev/null; then
  echo "Service $service_name exists in namespace $namespace."
else
  echo "Service $service_name does not exist in namespace $namespace."
  exit 1
fi

# Validate Port
expected_port="80"
actual_port=$(kubectl get svc "$service_name" -n "$namespace" -o=jsonpath="{.spec.ports[0].port}")
if [ "$actual_port" = "$expected_port" ]; then
  echo "Port is correctly set to $expected_port."
else
  echo "Port is not set to $expected_port (Current: $actual_port)."
  exit 1
fi

# Validate Protocol
expected_protocol="TCP"
actual_protocol=$(kubectl get svc "$service_name" -n "$namespace" -o=jsonpath="{.spec.ports[0].protocol}")
if [ "$actual_protocol" = "$expected_protocol" ]; then
  echo "Protocol is correctly set to $expected_protocol."
else
  echo "Protocol is not set to $expected_protocol (Current: $actual_protocol)."
  exit 1
fi

# Validate TargetPort
expected_target_port="80"
actual_target_port=$(kubectl get svc "$service_name" -n "$namespace" -o=jsonpath="{.spec.ports[0].targetPort}")
if [ "$actual_target_port" = "$expected_target_port" ]; then
  echo "TargetPort is correctly set to $expected_target_port."
else
  echo "TargetPort is not set to $expected_target_port (Current: $actual_target_port)."
  exit 1
fi

# Validate NodePort
expected_node_port="31000"
actual_node_port=$(kubectl get svc "$service_name" -n "$namespace" -o=jsonpath="{.spec.ports[0].nodePort}")
if [ "$actual_node_port" = "$expected_node_port" ]; then
  echo "NodePort is correctly set to $expected_node_port."
else
  echo "NodePort is not set to $expected_node_port (Current: $actual_node_port)."
  exit 1
fi

echo "Validation Passed!"