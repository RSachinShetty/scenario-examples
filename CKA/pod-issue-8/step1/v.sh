#!/bin/bash

# Port-forward to the nginx-service on localhost:8080
kubectl port-forward service/nginx-service 8081:80 &

# Wait for port-forwarding to be ready
sleep 5

# Use curl to access the port-forwarded service
curl_output=$(curl -s http://localhost:8081)

# Verify if the output contains "Welcome to nginx!"
if [[ $curl_output == *"Welcome to nginx!"* ]]; then
    echo "Validation PASSED: curl output contains 'Welcome to nginx!'."
else
    echo "Validation FAILED: curl output does not contain 'Welcome to nginx!'."
    exit 1
fi

# Clean up port-forwarding process
pkill -f "kubectl port-forward service/nginx-service 8081:80"
