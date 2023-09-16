#!/bin/bash

kubectl create ns redis-ns
kubectl create deployment redis-deploy --image=redis --replicas=1 -n redis-ns
