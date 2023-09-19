#!/bin/bash

# Check if the deployment exists
if kubectl get deployment my-web-app-deployment &> /dev/null; then
  echo "Deployment my-web-app-deployment exists."
else
  echo "Deployment my-web-app-deployment does not exist."
  exit 1
fi

# Check if the number of replicas is 2
replicas=$(kubectl get deployment my-web-app-deployment -o=jsonpath='{.spec.replicas}')
if [ "$replicas" -eq 2 ]; then
  echo "Deployment my-web-app-deployment has 2 replicas."
else
  echo "Deployment my-web-app-deployment does not have 2 replicas (Current: $replicas)."
  exit 1
fi

# Check if the image is wordpress
image=$(kubectl get deployment my-web-app-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image" = "wordpress" ]; then
  echo "Deployment my-web-app-deployment uses the wordpress image."
else
  echo "Deployment my-web-app-deployment does not use the wordpress image (Current: $image)."
  exit 1
fi

# Check if the service exists
if kubectl get service my-web-app-service &> /dev/null; then
  echo "Service my-web-app-service exists."
else
  echo "Service my-web-app-service does not exist."
  exit 1
fi

# Check if the service type is NodePort
service_type=$(kubectl get service my-web-app-service -o=jsonpath='{.spec.type}')
if [ "$service_type" = "NodePort" ]; then
  echo "Service my-web-app-service is of type NodePort."
else
  echo "Service my-web-app-service is not of type NodePort (Current: $service_type)."
  exit 1
fi

# Check if the service port is 80
service_port=$(kubectl get service my-web-app-service -o=jsonpath='{.spec.ports[0].port}')
if [ "$service_port" -eq 80 ]; then
  echo "Service my-web-app-service has port 80."
else
  echo "Service my-web-app-service does not have port 80 (Current: $service_port)."
  exit 1
fi

# Check if the service target port is 80
target_port=$(kubectl get service my-web-app-service -o=jsonpath='{.spec.ports[0].targetPort}')
if [ "$target_port" -eq 80 ]; then
  echo "Service my-web-app-service has targetPort 80."
else
  echo "Service my-web-app-service does not have targetPort 80 (Current: $target_port)."
  exit 1
fi

# Check if the service node port is 30770
node_port=$(kubectl get service my-web-app-service -o=jsonpath='{.spec.ports[0].nodePort}')
if [ "$node_port" -eq 30770 ]; then
  echo "Service my-web-app-service has nodePort 30770."
else
  echo "Service my-web-app-service does not have nodePort 30770 (Current: $node_port)."
  exit 1
fi