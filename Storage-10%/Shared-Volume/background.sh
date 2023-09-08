#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pink-pv-cka
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pink-pvc-cka
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
  name: pink-app-cka
spec:
  replicas: 2
  selector:
    matchLabels:
      app: pink-app-cka
  template:
    metadata:
      labels:
        app: pink-app-cka
    spec:
      containers:
        - name: nginx-container
          image: nginx
EOF