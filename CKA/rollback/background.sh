#!/bin/bash

kubectl create deployment redis-deployment --image=redis:7.0.13 --replicas=1
sleep 3
kubectl set image deployment/redis-deployment redis=redis:7.2.1