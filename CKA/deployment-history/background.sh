#!/bin/bash

kubectl create deployment video-app --image=redis:7.2.1 --replicas=1

kubectl set image deployment/video-app redis=redis:7.2.1-alpine

kubectl set image deployment/video-app redis=redis:7.0.13

