#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: log-configmap
data:
  log.txt: |
    <LOG DATA>
EOF