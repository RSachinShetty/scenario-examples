#!/bin/bash

kubectl label nodes node01 NodeName=frontendnodes

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: frontend
spec:
  containers:
    - name: my-container
      image: nginx:latest
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: NodeName
                operator: In
                values:
                  - frontend
EOF