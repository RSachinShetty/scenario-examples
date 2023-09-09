# PV Specifications
pv_name="my-pv-cka"
pv_storage_capacity="100Mi"
pv_access_mode="ReadWriteOnce"
pv_host_path="/mnt/data"
pv_storage_class="standard"

# Verify PV
pv_info=$(kubectl get pv "$pv_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: PV $pv_name not found."
  exit 1
fi

pv_capacity=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.capacity.storage}')
pv_mode=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.accessModes[0]}')
pv_path=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.hostPath.path}')
pv_class=$(kubectl get pv "$pv_name" -o=jsonpath='{.spec.storageClassName}')

if [ "$pv_capacity" == "$pv_storage_capacity" ] && [ "$pv_mode" == "$pv_access_mode" ] && [ "$pv_path" == "$pv_host_path" ] && [ "$pv_class" == "$pv_storage_class" ]; then
  echo "PV $pv_name meets the criteria."
else
  echo "Error: PV $pv_name does not meet the criteria."
  exit 1
fi

# Continue with PVC and Pod creation
# PVC Specifications
pvc_name="my-pvc-cka"
pvc_storage_class="standard"

# Verify PVC
pvc_info=$(kubectl get pvc "$pvc_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: PVC $pvc_name not found."
  exit 1
fi

pvc_class=$(kubectl get pvc "$pvc_name" -o=jsonpath='{.spec.storageClassName}')

if [ "$pvc_class" == "$pvc_storage_class" ]; then
  echo "PVC $pvc_name meets the criteria."
else
  echo "Error: PVC $pvc_name does not meet the criteria."
  exit 1
fi

# Continue with Pod creation
# Pod Specifications
pod_name="my-pod-cka"

# Verify Pod
pod_info=$(kubectl get pod "$pod_name" -o=json)
if [ $? -ne 0 ]; then
  echo "Error: Pod $pod_name not found."
  exit 1
fi

# Continue with PVC mounting
# Pod PVC Mount Verification
pod_volumes=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.volumes[0].persistentVolumeClaim.claimName}')
pod_mount_path=$(kubectl get pod "$pod_name" -o=jsonpath='{.spec.containers[0].volumeMounts[0].mountPath}')

if [ "$pod_volumes" == "$pvc_name" ] && [ "$pod_mount_path" == "/var/www/html" ]; then
  echo "Pod $pod_name meets the criteria."
else
  echo "Error: Pod $pod_name does not meet the criteria."
  exit 1
fi

# Pod Specifications
pod_name="my-pod-cka"

# Verify Pod Status
pod_status=$(kubectl get pod "$pod_name" -o=jsonpath='{.status.phase}')

if [ "$pod_status" == "Running" ]; then
  echo "Pod $pod_name is in Running state."
else
  echo "Error: Pod $pod_name is not in the expected Running state."
  exit 1
fi

echo "Validation successful!"
