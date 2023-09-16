# Check if the secret exists in the 'default' namespace
secret_name="database-app-secret"
namespace="default"

if kubectl get secret "$secret_name" -n "$namespace" &> /dev/null; then
  echo "Validation: Secret '$secret_name' exists in namespace '$namespace'."
else
  echo "Validation: Secret '$secret_name' does not exist in namespace '$namespace'."
  exit 1
fi

# Check if the secret contains a 'database-data.txt' key
if kubectl get secret "$secret_name" -n "$namespace" -o jsonpath='{.data}' | grep -q 'database-data.txt'; then
  echo "Validation: Secret '$secret_name' contains 'database-data.txt' key."
else
  echo "Validation: Secret '$secret_name' does not contain 'database-data.txt' key."
  exit 1
fi

# Decode and display the content of 'database-data.txt'
secret_data=$(kubectl get secret "$secret_name" -n "$namespace" -o jsonpath='{.data.database-data\.txt}' | base64 --decode)
echo "Secret Content:"
echo "$secret_data"