#!/bin/bash

# Check if the NetworkPolicy exists
if kubectl get networkpolicy my-app-network-policy &> /dev/null; then
    echo "Validation PASSED: NetworkPolicy my-app-network-policy exists."
else
    echo "Validation FAILED: NetworkPolicy my-app-network-policy does not exist."
    exit 1
fi

# Check if the NetworkPolicy specifies 'Ingress' and 'Egress' policy types
policy_types=$(kubectl get networkpolicy my-app-network-policy -o=jsonpath='{.spec.policyTypes[*]}')
if [ "$policy_types" == "Ingress Egress" ]; then
    echo "Validation PASSED: NetworkPolicy specifies 'Ingress' and 'Egress' policy types."
else
    echo "Validation FAILED: NetworkPolicy does not specify both 'Ingress' and 'Egress' policy types."
    exit 1
fi

# Check if the NetworkPolicy specifies the correct podSelector
pod_selector=$(kubectl get networkpolicy my-app-network-policy -o=jsonpath='{.spec.podSelector.matchLabels.app}')
if [ "$pod_selector" == "my-app" ]; then
    echo "Validation PASSED: NetworkPolicy specifies the correct podSelector."
else
    echo "Validation FAILED: NetworkPolicy does not specify the correct podSelector."
    exit 1
fi

# Check if the NetworkPolicy allows incoming traffic from any pod within the same namespace
ingress_from_any=$(kubectl get networkpolicy my-app-network-policy -o=jsonpath='{.spec.ingress[0].from[0].podSelector}')
if [ "$ingress_from_any" == "{}" ]; then
    echo "Validation PASSED: NetworkPolicy allows incoming traffic from any pod within the same namespace."
else
    echo "Validation FAILED: NetworkPolicy does not allow incoming traffic from any pod within the same namespace."
    exit 1
fi

# Check if the NetworkPolicy allows incoming traffic from pods labeled as "app=trusted" on port 80
ingress_from_trusted=$(kubectl get networkpolicy my-app-network-policy -o=jsonpath='{.spec.ingress[1].from[0].podSelector.matchLabels.app}')
if [ "$ingress_from_trusted" == "trusted" ]; then
    echo "Validation PASSED: NetworkPolicy allows incoming traffic from pods labeled as 'app=trusted' on port 80."
else
    echo "Validation FAILED: NetworkPolicy does not allow incoming traffic from pods labeled as 'app=trusted' on port 80."
    exit 1
fi

# Check if the NetworkPolicy allows outgoing traffic to any pod within the same namespace
egress_to_any=$(kubectl get networkpolicy my-app-network-policy -o=jsonpath='{.spec.egress[0].to[0].podSelector}')
if [ "$egress_to_any" == "{}" ]; then
    echo "Validation PASSED: NetworkPolicy allows outgoing traffic to any pod within the same namespace."
else
    echo "Validation FAILED: NetworkPolicy does not allow outgoing traffic to any pod within the same namespace."
    exit 1
fi

echo "Validation PASSED"
