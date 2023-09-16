#!/bin/bash

cat <<EOL > redis-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
spec:
  containers:
    - name: redis-container
      image: redis:latest
      resources:
        requests:
          memory: "150Mi"
          cpu: "15m"
        limits:
          memory: "100Mi"
          cpu: "10m"
EOL