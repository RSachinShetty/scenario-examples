#!/bin/bash

# Check if the ServiceAccount 'app-account' exists in the 'default' namespace
if kubectl get serviceaccount app-account -n default &>/dev/null; then
    echo "Validation passed: ServiceAccount 'app-account' exists in the 'default' namespace."
else
    echo "Validation failed: ServiceAccount 'app-account' does not exist in the 'default' namespace."
    exit 1
fi

# Validate Role
role_exists=$(kubectl get role app-role-cka -n default -o custom-columns=:.metadata.name --no-headers)
if [ "$role_exists" != "app-role-cka" ]; then
    echo "Validation failed: Role 'app-role-cka' not found or has incorrect name."
    exit 1
fi

# Validate Role verbs
role_verbs=$(kubectl get role app-role-cka -n default -o jsonpath='{.rules[0].verbs[*]}')
if [ "$role_verbs" != "get" ]; then
    echo "Validation failed: Role 'app-role-cka' does not have correct verbs. Expected: 'get', Found: '$role_verbs'."
    exit 1
fi

# Validate Role resources
role_resources=$(kubectl get role app-role-cka -n default -o jsonpath='{.rules[0].resources[*]}')
if [ "$role_resources" != "pods" ]; then
    echo "Validation failed: Role 'app-role-cka' does not have correct resources. Expected: 'pods', Found: '$role_resources'."
    exit 1
fi

# Validate RoleBinding
role_binding_exists=$(kubectl get rolebinding app-role-binding-cka -n default -o custom-columns=:.metadata.name --no-headers)
if [ "$role_binding_exists" != "app-role-binding-cka" ]; then
    echo "Validation failed: RoleBinding 'app-role-binding-cka' not found or has incorrect name."
    exit 1
fi

# Validate RoleBinding references the correct Role
role_binding_role_ref=$(kubectl get rolebinding app-role-binding-cka -n default -o jsonpath='{.roleRef.name}')
if [ "$role_binding_role_ref" != "app-role-cka" ]; then
    echo "Validation failed: RoleBinding 'app-role-binding-cka' does not reference the correct Role. Expected: 'app-role-cka', Found: '$role_binding_role_ref'."
    exit 1
fi

# Validate RoleBinding binds to the correct ServiceAccount
role_binding_subjects=$(kubectl get rolebinding app-role-binding-cka -n default -o jsonpath='{.subjects[0].name}')
if [ "$role_binding_subjects" != "app-account" ]; then
    echo "Validation failed: RoleBinding 'app-role-binding-cka' does not bind to the correct ServiceAccount. Expected: 'app-account', Found: '$role_binding_subjects'."
    exit 1
fi

echo "Validation passed: ServiceAccount, Role, and RoleBinding are correctly configured."
