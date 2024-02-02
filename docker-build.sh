#!/bin/bash

# Verify if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq não foi encontrado. Instale e tente novamente."
    echo "Ubuntu/Debian: sudo apt-get install jq"
    echo "MacOS: brew install jq"
    exit
fi

# Image name
IMAGE_NAME="my-image-name"

# Verify the current Git branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Check if the branch is "main"
if [ "$BRANCH" = "main" ]; then
  # Get the version from package.json
  VERSION=$(jq -r .version package.json)

  # Build the DOcker image with package.json version as tag
  docker build -t "$IMAGE_NAME":"$VERSION" -t "$IMAGE_NAME":latest -f Dockerfile .
else
  # Build the Docker image with the branch name as tag
  docker build -t "$IMAGE_NAME":"$BRANCH" -f Dockerfile .
fi
