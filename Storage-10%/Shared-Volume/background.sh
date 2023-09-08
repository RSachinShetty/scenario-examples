#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-pv-cka
spec:
  capacity:
    storage: 50Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-pvc-cka
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Mi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment-cka
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app-app-cka
  template:
    metadata:
      labels:
        app: app-app-cka
    spec:
      containers:
        - name: nginx-container
          image: nginx
EOF