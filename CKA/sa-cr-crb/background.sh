#!/bin/bash

#!/bin/bash

kubectl create serviceaccount group1-sa
kubectl create clusterrole group1-role-cka --verb=get --resource=deployments
kubectl create clusterrolebinding group1-role-binding-cka --clusterrole=group1-role-cka --serviceaccount=default:group1-sa