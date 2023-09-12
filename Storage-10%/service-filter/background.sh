#!/bin/bash

echo "#!/bin/bash" > svc-filter.sh

kubectl create service clusterip redis-service --tcp=6379:6379
