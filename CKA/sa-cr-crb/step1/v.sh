#!/bin/bash
 
# Validate Service Account
sa_exists=$(kubectl get serviceaccount group1-sa -n default -o custom-columns=:.metadata.name --no-headers)
if [ "$sa_exists" != "group1-sa" ]; then
  echo "Service account 'group1-sa' not found or has incorrect name."
  exit 1
fi

# Validate ClusterRole
role_exists=$(kubectl get clusterrole group1-role-cka -o custom-columns=:.metadata.name --no-headers)
if [ "$role_exists" != "group1-role-cka" ]; then
  echo "ClusterRole 'group1-role-cka' not found or has incorrect name."
  exit 1
fi

# Validate ClusterRole
role_rules=$(kubectl get clusterrole group1-role-cka -o jsonpath='{.rules[0].verbs[*]}' --no-headers)

expected_rules=("create" "get" "list")

for verb in "${expected_rules[@]}"; do
  if ! echo "$role_rules" | grep -q "$verb"; then
    echo "ClusterRole 'group1-role-cka' doesn't have the '$verb' rule."
    exit 1
  fi
done

# Validate ClusterRole resources
role_resources=$(kubectl get clusterrole group1-role-cka -o jsonpath='{.rules[0].resources[*]}' --no-headers)
expected_resources=("deployments")
if [ "$role_resources" != "${expected_resources[*]}" ]; then
    echo "ClusterRole 'group1-role-cka' has incorrect resources."
    exit 1
fi

echo "ClusterRole 'group1-role-cka' has the expected rules."


# Validate ClusterRoleBinding
role_binding_exists=$(kubectl get clusterrolebinding group1-role-binding-cka -o custom-columns=:.metadata.name --no-headers)
if [ "$role_binding_exists" != "group1-role-binding-cka" ]; then
  echo "ClusterRoleBinding 'group1-role-binding-cka' not found or has incorrect name."
  exit 1
fi

role_binding_role_ref=$(kubectl get clusterrolebinding group1-role-binding-cka -o custom-columns=:.roleRef.name --no-headers)
if [ "$role_binding_role_ref" != "group1-role-cka" ]; then
  echo "ClusterRoleBinding 'group1-role-binding-cka' doesn't reference 'group1-role-cka' ClusterRole."
  exit 1
fi

role_binding_subjects=$(kubectl get clusterrolebinding group1-role-binding-cka -o custom-columns=:.subjects[*].name --no-headers)
if [ "$role_binding_subjects" != "group1-sa" ]; then
  echo "ClusterRoleBinding 'group1-role-binding-cka' doesn't bind to 'group1-sa' ServiceAccount."
  exit 1
fi

echo "Validation passed. Service account, ClusterRole, and ClusterRoleBinding are correctly configured."
