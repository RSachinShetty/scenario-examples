#!/bin/bash

cat <<EOL > my-app-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-deployment
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
        image: nginx:latets
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "1000Mi"
            cpu: "5.0"        
          limits:
            memory: "100Mi"
            cpu: "0.5"  
EOL