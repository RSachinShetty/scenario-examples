#!/bin/bash

# Define the old and new server URLs
old_server="https://172.30.1.2:6443"
new_server="https://172.30.1.2:644333"

# Specify the path to the config file
config_file=".kube/config"

# Use sed to replace the old server URL with the new one in the config file
sed -i "s|$old_server|$new_server|g" "$config_file"

# Check if sed was successful (exit code 0) or not (exit code 1)
if [ $? -eq 0 ]; then
  echo "Server URL updated successfully."
else
  echo "Error: Failed to update server URL."
fi
