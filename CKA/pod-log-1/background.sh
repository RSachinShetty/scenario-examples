#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: product
spec:
  containers:
  - name: product-container
    image: busybox
    command: ["sh", "-c", "echo 'Mi Tv Is Good' && sleep 3600"]
EOF
