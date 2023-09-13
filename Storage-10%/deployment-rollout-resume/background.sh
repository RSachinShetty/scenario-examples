#!/bin/bash

kubectl create deployment stream-deployment --image=redis:7.2.1 --replicas=0
