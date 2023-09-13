#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres-container
          image: postgres:latest
          env:
            - name: POSTGRES_DB
              value: mydatabase
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: postgres-secrte
                  key: db_user
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: db_password
          ports:
            - containerPort: 5432

---

apiVersion: v1
kind: Secret
metadata:
  name: postgres-secret
type: Opaque
data:
  username: ZGJ1c2VyCg==
  password: ZGJwYXNzd29yZAo=
EOF