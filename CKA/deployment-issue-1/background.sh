#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-configmap
data:
  nginx.conf: |
    server {
        listen 80;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            index index.html;
        }
    }

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      initContainers:
        - name: init-container
          image: busybox
          command:
            - shell
            - echo 'Welcome To KillerCoda!'
          volumeMounts:
            - mountPath: /etc/nginx/nginx.conf
              name: nginx-config
      containers:
        - name: nginx-container
          image: nginx:latest
          ports:
            - containerPort: 80
      volumes:
        - name: nginx-config
          configMap:
            name: nginx-configuration
EOF