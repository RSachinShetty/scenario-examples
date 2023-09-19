#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-deployment
  labels:
    app: trusted
spec:
  replicas: 2
  selector:
    matchLabels:
      app: trusted
  template:
    metadata:
      labels:
        app: trusted
    spec:
      containers:
        - name: my-app-container
          image: nginx:latest
---
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  selector:
    app: trusted
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF