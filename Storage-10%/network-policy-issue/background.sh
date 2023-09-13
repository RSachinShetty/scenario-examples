#!/bin/bash

red-pod & red-service is running 
kubectl run red-pod --image=nginx
kubectl expose pod red-pod --name red-service --port=80 --target-port=80

kubectl run green-pod --image=tomcat

kubectl run blue-pod --image=redis

kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-green-and-blue
spec:
  podSelector:
    matchLabels:
      run: red-pod
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              run: green-pod
        - podSelector:
            matchLabels:
              run: blue-pod
EOF