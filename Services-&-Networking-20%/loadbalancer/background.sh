#!/bin/bash

kubectl create ns nginx-app-space

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-app-cka
  namespace: nginx-app-space
  labels:
    app: nginx-app-cka
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-app-cka
  template:
    metadata:
      labels:
        app: nginx-app-cka
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          ports:
            - containerPort: 80
EOF