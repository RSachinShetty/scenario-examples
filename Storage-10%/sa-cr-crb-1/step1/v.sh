#!/bin/bash

# Check if the ServiceAccount 'app-account' exists in the 'default' namespace
if kubectl get serviceaccount app-account -n default &>/dev/null; then
    echo "Validation passed: ServiceAccount 'app-account' exists in the 'default' namespace."
else
    echo "Validation failed: ServiceAccount 'app-account' does not exist in the 'default' namespace."
    exit 1  # Exit with failure status code
fi

# Validate ClusterRole
role_exists=$(kubectl get clusterrole app-role-cka -o custom-columns=:.metadata.name --no-headers)
if [ "$role_exists" != "app-role-cka" ]; then
    echo "ClusterRole 'app-role-cka' not found or has incorrect name."
    exit 1
fi

# Validate ClusterRole verbs
role_rules=$(kubectl get clusterrole app-role-cka -o jsonpath='{.rules[0].verbs[*]}' --no-headers)
expected_rules=("get")
if [ "$role_rules" != "${expected_rules[*]}" ]; then
    echo "ClusterRole 'app-role-cka' has incorrect verbs."
    exit 1
fi

# Validate ClusterRole resources
role_resources=$(kubectl get clusterrole app-role-cka -o jsonpath='{.rules[0].resources[*]}' --no-headers)
expected_resources=("pods")
if [ "$role_resources" != "${expected_resources[*]}" ]; then
    echo "ClusterRole 'app-role-cka' has incorrect resources."
    exit 1
fi

# Validate ClusterRoleBinding
role_binding_exists=$(kubectl get clusterrolebinding app-role-binding-cka -o custom-columns=:.metadata.name --no-headers)
if [ "$role_binding_exists" != "app-role-binding-cka" ]; then
    echo "ClusterRoleBinding 'app-role-binding-cka' not found or has incorrect name."
    exit 1
fi

role_binding_role_ref=$(kubectl get clusterrolebinding app-role-binding-cka -o custom-columns=:.roleRef.name --no-headers)
if [ "$role_binding_role_ref" != "app-role-cka" ]; then
    echo "ClusterRoleBinding 'app-role-binding-cka' doesn't reference 'app-role-cka' ClusterRole."
    exit 1
fi

role_binding_subjects=$(kubectl get clusterrolebinding app-role-binding-cka -o custom-columns=:.subjects[*].name --no-headers)
if [ "$role_binding_subjects" != "app-account" ]; then
    echo "ClusterRoleBinding 'app-role-binding-cka' doesn't bind to 'app-account' ServiceAccount."
    exit 1
fi

echo "Validation passed. Service account, ClusterRole, and ClusterRoleBinding are correctly configured."
