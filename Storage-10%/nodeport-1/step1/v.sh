#!/bin/bash

# Check if the deployment exists
if kubectl get deployment my-web-app-deployment &> /dev/null; then
    echo "Validation PASSED: Deployment my-web-app-deployment exists."
else
    echo "Validation FAILED: Deployment my-web-app-deployment does not exist."
    exit 1
fi

# Check if there are exactly 2 replicas in the deployment
replica_count=$(kubectl get deployment my-web-app-deployment -o=jsonpath='{.status.replicas}')
if [ "$replica_count" -eq 2 ]; then
    echo "Validation PASSED: Deployment my-web-app-deployment has 2 replicas."
else
    echo "Validation FAILED: Deployment my-web-app-deployment does not have 2 replicas."
    exit 1
fi

# Check if the deployment uses the correct Docker image
deployment_image=$(kubectl get deployment my-web-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$deployment_image" == "wordpress" ]; then
    echo "Validation PASSED: Deployment my-web-app-deployment uses the correct Docker image."
else
    echo "Validation FAILED: Deployment my-web-app-deployment does not use the correct Docker image."
    exit 1
fi

# Check if the service exists
if kubectl get svc my-web-app-service &> /dev/null; then
    echo "Validation PASSED: Service my-web-app-service exists."
else
    echo "Validation FAILED: Service my-web-app-service does not exist."
    exit 1
fi

# Check if the service type is NodePort
service_type=$(kubectl get svc my-web-app-service -o=jsonpath='{.spec.type}')
if [ "$service_type" == "NodePort" ]; then
    echo "Validation PASSED: Service my-web-app-service is of type NodePort."
else
    echo "Validation FAILED: Service my-web-app-service is not of type NodePort."
    exit 1
fi

# Check if the service's targetPort and nodePort are correctly set to 80
target_port=$(kubectl get svc my-web-app-service -o=jsonpath='{.spec.ports[0].targetPort}')
node_port=$(kubectl get svc my-web-app-service -o=jsonpath='{.spec.ports[0].nodePort}')

if [ "$target_port" == "80" ] && [ "$node_port" == "30770" ]; then
    echo "Validation PASSED: Service my-web-app-service has the correct targetPort and nodePort."
else
    echo "Validation FAILED: Service my-web-app-service does not have the correct targetPort and nodePort."
    exit 1
fi

echo "Validation PASSED"