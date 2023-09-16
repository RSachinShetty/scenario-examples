#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: hello-kubernetes
spec:
  containers:
    - name: echo-container
      image: redis
      command: ["shell", "-c", "while true; do echo 'Hello Kubernetes'; sleep 5; done"]
EOF