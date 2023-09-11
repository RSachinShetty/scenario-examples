# Check if the video-app deployment pods are running
if kubectl get deployment video-app &> /dev/null; then
    echo "Validation PASSED: Deployment video-app exists."
    # Check if there are 1 replica running (as per the rollback)
    replica_count=$(kubectl get deployment video-app -o=jsonpath='{.status.replicas}')
    if [ "$replica_count" -eq 1 ]; then
        echo "Validation PASSED: Deployment video-app has 1 replica running."
    else
        echo "Validation FAILED: Deployment video-app does not have the expected number of replicas."
        exit 1
    fi
else
    echo "Validation FAILED: Deployment video-app does not exist."
    exit 1
fi

# Check the content of the app-file.txt
file_content=$(cat app-file.txt)
if [ "$file_content" == "3,redis:7.0.13" ]; then
    echo "Validation PASSED: app-file.txt contains the expected content."
else
    echo "Validation FAILED: app-file.txt does not contain the expected content."
    exit 1
fi

echo "Validation PASSED"
