#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp-deployment
  template:
    metadata:
      labels:
        app: webapp-deployment
    spec:
      containers:
      - name: webapp-container
        image: nginx:latest
        ports:
        - containerPort: 80
        env:
        - name: APPLICATION
          value: web-app
EOF