#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp-container
        image: nginx:latest
        env:
        - name: DB_Host
          value: mysql-host
        - name: DB_User
          value: root
        - name: DB_Password
          value: dbpassword
        ports:
        - containerPort: 80
EOF