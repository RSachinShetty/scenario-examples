#!/bin/bash

# Define the expected string
expected_string="secret"
 
# Read the contents of the decoded.txt file
file_contents=$(cat decoded.txt)

# Check if the file contents contain the expected string
if [[ $file_contents == *"$expected_string"* ]]; then
    echo "Validation passed: 'decoded.txt' contains '$expected_string'."
    exit 0
else
    echo "Validation failed: 'decoded.txt' does not contain '$expected_string'."
    exit 1
fi
