#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-deployment
  labels:
    app: my-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app-container
          image: nginx:latest
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cache-deployment
  labels:
    app: trusted
spec:
  replicas: 1
  selector:
    matchLabels:
      app: trusted
  template:
    metadata:
      labels:
        app: trusted
    spec:
      containers:
        - name: trusted-container
          image: redis:latest
---
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF