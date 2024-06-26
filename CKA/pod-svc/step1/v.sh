#!/bin/bash

SERVICE_NAME="app-svc"
NAMESPACE="default" # Change this to the appropriate namespace if needed

# Get the selector of the service
SELECTOR=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.spec.selector.app}')

# Check if the selector is "app-lab"
if [ "$SELECTOR" = "app-lab" ]; then
  echo "The service $SERVICE_NAME has the correct selector: app=app-lab"
else
  echo "The service $SERVICE_NAME does not have the correct selector. Current selector: app=$SELECTOR"
  exit 1
fi

# Forward port 8080 from app-pod to localhost
kubectl port-forward pod/app-pod 8080:80 &

# Wait for port-forwarding to become available
sleep 5

# Perform the curl request to the local port
response=$(curl -s http://localhost:8080)

# Check if the response matches the expected output
expected_output="<html><body><h1>It works!</h1></body></html>"
 
if [ "$response" = "$expected_output" ]; then
  echo "Verification successful: Web application is accessible."
else
  echo "Verification failed: Web application is not accessible as expected."
  exit 1
fi

# Terminate the background port-forwarding process
pkill -f "kubectl port-forward pod/app-pod 8080:80"
