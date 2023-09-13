#!/bin/bash

# Validate PostgreSQL Deployment
deployment_exists=$(kubectl get deployment postgres-deployment -o custom-columns=:.metadata.name --no-headers)
if [ "$deployment_exists" == "postgres-deployment" ]; then
  echo "Deployment 'postgres-deployment' found."
else
  echo "Deployment 'postgres-deployment' not found or has an incorrect name."
  exit 1
fi

# Validate PostgreSQL Deployment Replica Count
replica_count=$(kubectl get deployment postgres-deployment -o custom-columns=:.spec.replicas --no-headers)
if [ "$replica_count" == 1 ]; then
  echo "Deployment 'postgres-deployment' has the correct replica count."
else
  echo "Deployment 'postgres-deployment' has an incorrect replica count."
  exit 1
fi

# Validate PostgreSQL Container Image
container_image=$(kubectl get deployment postgres-deployment -o jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$container_image" == "postgres:latest" ]; then
  echo "Deployment 'postgres-deployment' is using the correct container image."
else
  echo "Deployment 'postgres-deployment' is using an incorrect container image."
  exit 1
fi

# Validate PostgreSQL Environment Variables (POSTGRES_DB)
db_name=$(kubectl get deployment postgres-deployment -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="POSTGRES_DB")].value}')
if [ "$db_name" == "mydatabase" ]; then
  echo "Deployment 'postgres-deployment' has the correct POSTGRES_DB value."
else
  echo "Deployment 'postgres-deployment' has an incorrect POSTGRES_DB value."
  exit 1
fi

# Validate PostgreSQL Environment Variables (POSTGRES_USER)
db_user=$(kubectl get deployment postgres-deployment -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="POSTGRES_USER")].valueFrom.secretKeyRef.key}')
if [ "$db_user" == "username" ]; then
  echo "Deployment 'postgres-deployment' has the correct POSTGRES_USER value."
else
  echo "Deployment 'postgres-deployment' has an incorrect POSTGRES_USER value."
  exit 1
fi

# Validate PostgreSQL Environment Variables (POSTGRES_PASSWORD)
db_password=$(kubectl get deployment postgres-deployment -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="POSTGRES_PASSWORD")].valueFrom.secretKeyRef.key}')
if [ "$db_password" == "password" ]; then
  echo "Deployment 'postgres-deployment' has the correct POSTGRES_PASSWORD value."
else
  echo "Deployment 'postgres-deployment' has an incorrect POSTGRES_PASSWORD value."
  exit 1
fi

# Check if the pod is running
pod_status=$(kubectl get pod -l app=postgres -o jsonpath='{.items[0].status.phase}')
if [ "$pod_status" == "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi

echo "Validation passed. Deployment 'postgres-deployment' and pod are correctly configured."
