#!/bin/bash

# Check if the Secret 'db-secret' exists
if kubectl get secret db-secret &> /dev/null; then
    echo "Validation PASSED: Secret 'db-secret' exists."
else
    echo "Validation FAILED: Secret 'db-secret' does not exist."
    exit 1
fi

# Check the type of the Secret
secret_type=$(kubectl get secret db-secret -o=jsonpath='{.type}')
if [ "$secret_type" == "Opaque" ]; then
    echo "Validation PASSED: Secret 'db-secret' type is Opaque."
else
    echo "Validation FAILED: Secret 'db-secret' type is not Opaque."
    exit 1
fi

# Check if the Secret data matches expected values
db_host=$(kubectl get secret db-secret -o=jsonpath='{.data.DB_Host}' | base64 -d)
db_user=$(kubectl get secret db-secret -o=jsonpath='{.data.DB_User}' | base64 -d)
db_password=$(kubectl get secret db-secret -o=jsonpath='{.data.DB_Password}' | base64 -d)

if [ "$db_host" == "mysql-host" ] && [ "$db_user" == "root" ] && [ "$db_password" == "dbpassword" ]; then
    echo "Validation PASSED: Secret data matches expected values."
else
    echo "Validation FAILED: Secret data does not match expected values."
    exit 1
fi

echo "Validation PASSED: Secret 'db-secret' is correctly configured."

# Check if the Deployment 'webapp-deployment' exists
if kubectl get deployment webapp-deployment &> /dev/null; then
    echo "Validation PASSED: Deployment 'webapp-deployment' exists."
else
    echo "Validation FAILED: Deployment 'webapp-deployment' does not exist."
    exit 1
fi

# Check if pods are running for the deployment
pod_status=$(kubectl get pods -l app=webapp -o=jsonpath='{.items[*].status.phase}')
if [[ "$pod_status" =~ "Running" ]]; then
    echo "Validation PASSED: All pods are in 'Running' state."
else
    echo "Validation FAILED: Some pods are not in 'Running' state."
    exit 1
fi

# Check if the correct image ('nginx:latest') is used
image_used=$(kubectl get deployment webapp-deployment -o=jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image_used" == "nginx:latest" ]; then
    echo "Validation PASSED: Correct image 'nginx:latest' is used."
else
    echo "Validation FAILED: Incorrect image is used."
    exit 1
fi

# Check if all three secrets are configured correctly
db_host_secret=$(kubectl get secret db-secret -o=jsonpath='{.data.DB_Host}' | base64 -d)
db_user_secret=$(kubectl get secret db-secret -o=jsonpath='{.data.DB_User}' | base64 -d)
db_password_secret=$(kubectl get secret db-secret -o=jsonpath='{.data.DB_Password}' | base64 -d)

if [ "$db_host_secret" == "mysql-host" ] && [ "$db_user_secret" == "root" ] && [ "$db_password_secret" == "dbpassword" ]; then
    echo "Validation PASSED: Secrets are correctly configured."
else
    echo "Validation FAILED: Secrets are not correctly configured."
    exit 1
fi

echo "Validation PASSED: Deployment 'webapp-deployment' is correctly configured."

# Additional validations can be added as needed

