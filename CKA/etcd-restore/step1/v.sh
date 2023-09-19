#!/bin/bash

backup_file="/opt/cluster_backup.db"
db_file="/root/default.etcd"
validation_string="restored snapshot"

# Check if the file exists
if [ ! -f "$backup_file" ]; then
    echo "Restore file '$backup_file' does not exist."
    exit 1  # Exit with failure status code
fi

# Use test -e to check if the file exists
if test -e "$db_file"; then
    echo "File '$db_file' exists."
else
    echo "File '$db_file' does not exist."
    exit 1  # Exit with failure status code
fi


# Check if the file 'restore.txt' exists
if [ ! -f "restore.txt" ]; then
    echo "Validation failed: 'restore.txt' file not found."
    exit 1
fi

# Check if the validation string exists in the 'restore.txt' file
if grep -q "$validation_string" "restore.txt"; then
    echo "Validation passed: 'restore.txt' contains the expected string."
else
    echo "Validation failed: 'restore.txt' does not contain the expected string."
    exit 1
fi

# Check if the validation string exists in the 'restore.txt' file
if grep -q "information from the backend" "restore.txt"; then
    echo "Validation passed: 'restore.txt' contains the expected string."
else
    echo "Validation failed: 'restore.txt' does not contain the expected string."
    exit 1
fi