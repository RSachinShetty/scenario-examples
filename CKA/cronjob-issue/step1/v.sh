#!/bin/bash

# Define the Pod name and namespace
POD_NAME="hello-world-pod"
NAMESPACE="default"

# Check if the Pod is running
pod_status=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
if [ "$pod_status" = "Running" ]; then
  echo "Pod is running."
else
  echo "Pod is not running."
  exit 1
fi

# Check if the 'hello-world-service' Service exists
if kubectl get service hello-world-service >/dev/null 2>&1; then
  echo "Service 'hello-world-service' exists."
else
  echo "Service 'hello-world-service' does not exist."
  exit 1
fi

# Check if the 'hello-world-cronjob' CronJob exists
if kubectl get cronjob hello-world-cronjob >/dev/null 2>&1; then
  echo "CronJob 'hello-world-cronjob' exists."
else
  echo "CronJob 'hello-world-cronjob' does not exist."
  exit 1
fi
# Check if the CronJob has the expected schedule and command
SCHEDULE=$(kubectl get cronjob hello-world-cronjob -o jsonpath='{.spec.schedule}')
COMMAND=$(kubectl get cronjob hello-world-cronjob -o jsonpath='{.spec.jobTemplate.spec.template.spec.containers[0].command[*]}')

EXPECTED_SCHEDULE="*/1 * * * *"
EXPECTED_COMMAND="curl hello-world-service"

if [ "$SCHEDULE" = "$EXPECTED_SCHEDULE" ] && [ "$COMMAND" = "$EXPECTED_COMMAND" ]; then
  echo "CronJob schedule and command match the expected values."
else
  echo "CronJob schedule or command does not match the expected values."
  exit 1
fi

exit 0