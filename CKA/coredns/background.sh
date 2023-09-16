#!/bin/bash

kubectl patch service -n kube-system kube-dns -p '{"spec":{"selector":{"k8s-app": "core-dns"}}}'