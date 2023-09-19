#!/bin/bash

kubectl scale deploy coredns -n kube-system --replicas=0
#EASY