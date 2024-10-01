#!/bin/bash

# Read inputs
GITHUB_TOKEN=$1
NEXT_PIPELINE=$2
VERSION=$3
OWNER="daosgava"
REPO="daniel-garcia-sit772-10-hd"

# Check if required arguments are provided
if [ -z "$GITHUB_TOKEN" ] || [ -z "$NEXT_PIPELINE" ]; then
  echo "Usage: ./trigger-e2e-tests.sh <GITHUB_TOKEN> <NEXT_PIPELINE>"
  exit 1
fi

# Trigger the E2E tests by sending a repository dispatch event
echo "Triggering the E2E tests..."
curl -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.everest-preview+json" \
  https://api.github.com/repos/$OWNER/$REPO/dispatches \
  -d "{\"event_type\":\"run-tests\", \"client_payload\": {\"next_pipeline\":\"$NEXT_PIPELINE\" , \"version\":\"$VERSION\"}}"

if [ $? -eq 0 ]; then
  echo "E2E tests triggered successfully."
else
  echo "Failed to trigger E2E tests."
  exit 1
fi
