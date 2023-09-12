#!/bin/bash

EXPECTED_CONTENT="ERROR: Mon Oct 1 10:30:23 UTC 2023 Log in Error!
INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!"

# Read the content of allpod.txt
ACTUAL_CONTENT=$(cat allpod.txt)

# Compare the actual content with the expected content
if [ "$EXPECTED_CONTENT" = "$ACTUAL_CONTENT" ]; then
  echo "Validation passed: The content in allpod.txt matches the expected pattern."
  exit 0
else
  echo "Validation failed: The content in allpod.txt does not match the expected pattern."
  exit 1
fi
