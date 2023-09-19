#!/bin/bash

backup_file="/opt/cluster_backup.db"
validation_string="Snapshot saved at /opt/cluster_backup.db"

# Check if the file exists
if [ ! -f "$backup_file" ]; then
    echo "Backup file '$backup_file' does not exist."
    exit 1  # Exit with failure status code
fi

# Check if the file 'backup.txt' exists
if [ ! -f "backup.txt" ]; then
    echo "Validation failed: 'backup.txt' file not found."
    exit 1
fi

# Check if the validation string exists in the 'backup.txt' file
if grep -q "$validation_string" "backup.txt"; then
    echo "Validation passed: 'backup.txt' contains the expected string."
else
    echo "Validation failed: 'backup.txt' does not contain the expected string."
    exit 1
fi

validation_string_1='"msg":"saved","path":"/opt/cluster_backup.db"'

# Check if the validation string exists in the 'backup.txt' file
if grep -q "$validation_string_1" "backup.txt"; then
    echo "Validation passed: 'backup.txt' contains the expected string."
else
    echo "Validation failed: 'backup.txt' does not contain the expected string."
    exit 1
fi