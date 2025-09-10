#!/bin/bash

# Script to run OBP API using pre-built Docker image from Docker Hub
# This script properly handles environment variables and Docker execution

set -e

# Default configuration
OBP_CONNECTOR=${OBP_CONNECTOR:-"mapped"}
OBP_HOSTNAME=${OBP_HOSTNAME:-"http://localhost:8080"}
OBP_DB_URL=${OBP_DB_URL:-"jdbc:postgresql://host.docker.internal:5433/obpapi?user=postgres&password=1"}
AUTH_USER_SKIP_EMAIL_VALIDATION=${AUTH_USER_SKIP_EMAIL_VALIDATION:-"true"}

# Super Admin Configuration
SUPER_ADMIN_USERNAME=${SUPER_ADMIN_USERNAME:-"admin"}
SUPER_ADMIN_PASSWORD=${SUPER_ADMIN_PASSWORD:-"admin123456"}
SUPER_ADMIN_EMAIL=${SUPER_ADMIN_EMAIL:-"admin@example.com"}
SUPER_ADMIN_USER_IDS=${SUPER_ADMIN_USER_IDS:-"26170288-5311-4eef-b878-838b46d0496c"}

echo "Starting OBP API with pre-built Docker image..."
echo "Connector: $OBP_CONNECTOR"
echo "Hostname: $OBP_HOSTNAME"
echo "Database URL: $OBP_DB_URL"
echo "Skip Email Validation: $AUTH_USER_SKIP_EMAIL_VALIDATION"
echo "Super Admin Username: $SUPER_ADMIN_USERNAME"
echo "Super Admin Email: $SUPER_ADMIN_EMAIL"
if [ -n "$SUPER_ADMIN_USER_IDS" ]; then
    echo "Super Admin User IDs: $SUPER_ADMIN_USER_IDS"
fi

# Change to the project directory
cd "$(dirname "$0")"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Pull the latest image if requested
if [ "$1" = "--pull" ] || [ "$1" = "-p" ]; then
    echo "Pulling latest OBP API image..."
    docker pull openbankproject/obp-api
fi

# Run the container with proper environment variable handling
echo "Starting OBP API container..."
docker run --rm -it \
    -p 8080:8080 \
    -e "OBP_CONNECTOR=$OBP_CONNECTOR" \
    -e "OBP_HOSTNAME=$OBP_HOSTNAME" \
    -e "OBP_DB_URL=$OBP_DB_URL" \
    -e "OBP_AUTHUSER_SKIPEMAILVALIDATION=$AUTH_USER_SKIP_EMAIL_VALIDATION" \
    -e "OBP_SUPER_ADMIN_USER_IDS=$SUPER_ADMIN_USER_IDS" \
    --add-host="host.docker.internal:host-gateway" \
    openbankproject/obp-api

echo "OBP API container stopped."
