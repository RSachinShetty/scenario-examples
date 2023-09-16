#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: cache-daemonset
spec:
  selector:
    matchLabels:
      app: cache
  template:
    metadata:
      labels:
        app: cache
    spec:
      containers:
      - name: cache-container
        image: redis:latest
        resources:
          limits:
            memory: "100Mi"
            cpu: "10m"
          requests:
            memory: "50Mi"
            cpu: "5m"
EOF