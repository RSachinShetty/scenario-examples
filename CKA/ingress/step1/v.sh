#!/bin/bash

# Check if the Ingress resource exists
if kubectl get ingress nginx-ingress-resource &> /dev/null; then
    echo "Validation PASSED: Ingress resource nginx-ingress-resource exists."
else
    echo "Validation FAILED: Ingress resource nginx-ingress-resource does not exist."
    exit 1
fi

# Check if the Ingress resource has the correct annotations
ssl_redirect=$(kubectl get ingress nginx-ingress-resource -o jsonpath='{.metadata.annotations.nginx\.ingress\.kubernetes\.io/ssl-redirect}')
if [ "$ssl_redirect" = "false" ]; then
    echo "Validation PASSED: Ingress resource has the correct ssl-redirect annotation."
else
    echo "Validation FAILED: Ingress resource does not have the correct ssl-redirect annotation."
    exit 1
fi

# Check if the Ingress resource has the correct pathType, path, backend service name, and port
path_type=$(kubectl get ingress nginx-ingress-resource -o jsonpath='{.spec.rules[0].http.paths[0].pathType}')
path=$(kubectl get ingress nginx-ingress-resource -o jsonpath='{.spec.rules[0].http.paths[0].path}')
backend_service_name=$(kubectl get ingress nginx-ingress-resource -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.name}')
backend_service_port=$(kubectl get ingress nginx-ingress-resource -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.port.number}')

if [ "$path_type" = "Prefix" ] && [ "$path" = "/shop" ] && [ "$backend_service_name" = "nginx-service" ] && [ "$backend_service_port" = "80" ]; then
    echo "Validation PASSED: Ingress resource has the correct pathType, path, backend service name, and port."
else
    echo "Validation FAILED: Ingress resource does not have the correct pathType, path, backend service name, or port."
    exit 1
fi

echo "Validation PASSED"
