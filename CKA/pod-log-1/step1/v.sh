#!/bin/bash

# Run the `k logs product` command and capture the output
logs_output=$(kubectl logs product 2>&1)

# Define the expected text
expected_text="Sony Tv Is Good"

# Check if the expected text is present in the command output
if [[ $logs_output == *"$expected_text"* ]]; then
    echo "Validation passed: The expected text '$expected_text' was found in the logs."
    exit 0  # Exit with success status code
else
    echo "Validation failed: The expected text '$expected_text' was not found in the logs."
    exit 1  # Exit with failure status code
fi
