#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx:latest
    resources:
      requests:
        memory: "5Gi"
      limits:
        memory: "10Gi"
EOF