# Validate Service Account
sa_exists=$(kubectl get serviceaccount prod-sa -n default -o custom-columns=:.metadata.name --no-headers)
if [ "$sa_exists" != "prod-sa" ]; then
  echo "Service account 'prod-sa' not found or has incorrect name."
  exit 1
fi

# Validate Role
role_exists=$(kubectl get role prod-role-cka -o custom-columns=:.metadata.name --no-headers)
if [ "$role_exists" != "prod-role-cka" ]; then
  echo "Role 'prod-role-cka' not found or has incorrect name."
  exit 1
fi

# Validate Role
role_rules=$(kubectl get role prod-role-cka -o jsonpath='{.rules[0].verbs[*]}' --no-headers)
expected_rules=("create" "get" "list")
for verb in "${expected_rules[@]}"; do
  if ! echo "$role_rules" | grep -q "$verb"; then
    echo "Role 'prod-role-cka' doesn't have the '$verb' rule."
    exit 1
  fi
done

echo "Role 'prod-role-cka' has the expected rules."

# Validate ClusterRole resources
role_resources=$(kubectl get role prod-role-cka -o jsonpath='{.rules[0].resources[*]}' --no-headers)
expected_resources=("services")
for resources in "${expected_resources[@]}"; do
  if ! echo "$role_resources" | grep -q "$resources"; then
    echo "Role 'prod-role-cka' doesn't have the '$resources' rule."
    exit 1
  fi
done

if [ "$role_resources" != "${expected_resources[*]}" ]; then
    echo "Role 'prod-role-cka' has incorrect resources."
    exit 1
fi

# Validate RoleBinding
role_binding_exists=$(kubectl get rolebinding prod-role-binding-cka  -o custom-columns=:.metadata.name --no-headers)
if [ "$role_binding_exists" != "prod-role-binding-cka" ]; then
  echo "RoleBinding 'prod-role-binding-cka ' not found or has incorrect name."
  exit 1
fi

role_binding_role_ref=$(kubectl get rolebinding prod-role-binding-cka  -o custom-columns=:.roleRef.name --no-headers)
if [ "$role_binding_role_ref" != "prod-role-cka" ]; then
  echo "RoleBinding 'prod-role-binding-cka ' doesn't reference 'prod-role-cka' Role."
  exit 1
fi

role_binding_subjects=$(kubectl get rolebinding prod-role-binding-cka  -o custom-columns=:.subjects[*].name --no-headers)
if [ "$role_binding_subjects" != "prod-sa" ]; then
  echo "Binding 'prod-role-binding-cka ' doesn't bind to 'prod-sa' ServiceAccount."
  exit 1
fi

echo "Validation passed. Service account, Role, and RoleBinding are correctly configured."
