#!/bin/bash

# Define the expected text
expected_text="kubernetes-admin@kubernetes,controlplane"

# Specify the path to the file
file_path="high_memory_node.txt"

# Check if the file exists
if [ -e "$file_path" ]; then
    # Check if the expected text is present in the file
    if grep -q "$expected_text" "$file_path"; then
        echo "Validation passed: The file contains the expected text."
    else
        echo "Validation failed: The file does not contain the expected text."
        exit 1  # Exit with failure status code
    fi
else
    echo "Validation failed: The file does not exist."
    exit 1  # Exit with failure status code
fi
