#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: cka-pod
spec:
  containers:
    - name: cka-container
      image: nginx:latest
---

apiVersion: v1
kind: Service
metadata:
  name: cka-service
spec:
  selector:
    app: cka-pod
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

---

apiVersion: batch/v1
kind: CronJob
metadata:
  name: cka-cronjob
spec:
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: curl-container
              image: curlimages/curl:latest
              command: ["curl", "cka-pod"]
          restartPolicy: OnFailure

EOF