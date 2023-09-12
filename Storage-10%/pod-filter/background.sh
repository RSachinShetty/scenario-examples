#!/bin/bash

echo "#!/bin/bash" > pod-filter.sh

kubectl run nginx-pod --image=nginx --labels=application=frontend