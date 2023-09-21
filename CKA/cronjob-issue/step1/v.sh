#!/bin/bash

# Define the Pod name and namespace
POD_NAME="cka-pod"
NAMESPACE="default"

# Check if the Pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi

# Check if the 'cka-service' Service exists
if kubectl get service cka-service >/dev/null 2>&1; then
  echo "Service 'cka-service' exists."
else
  echo "Service 'cka-service' does not exist."
  exit 1
fi

# Check if the 'cka-cronjob' CronJob exists
if kubectl get cronjob cka-cronjob >/dev/null 2>&1; then
  echo "CronJob 'cka-cronjob' exists."
else
  echo "CronJob 'cka-cronjob' does not exist."
  exit 1
fi
# Check if the CronJob has the expected schedule and command
SCHEDULE=$(kubectl get cronjob cka-cronjob -o jsonpath='{.spec.schedule}')
COMMAND=$(kubectl get cronjob cka-cronjob -o jsonpath='{.spec.jobTemplate.spec.template.spec.containers[0].command[*]}')

EXPECTED_SCHEDULE="*/1 * * * *"
EXPECTED_COMMAND="curl cka-service"

if [ "$SCHEDULE" = "$EXPECTED_SCHEDULE" ] && [ "$COMMAND" = "$EXPECTED_COMMAND" ]; then
  echo "CronJob schedule and command match the expected values."
else
  echo "CronJob schedule or command does not match the expected values."
  exit 1
fi

exit 0