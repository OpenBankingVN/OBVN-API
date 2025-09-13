# OBP API Docker Setup Guide

This guide explains how to run the Open Bank Project (OBP) API using Docker with the provided script.

## Overview

The `run_obp_docker.sh` script simplifies running the OBP API using a pre-built Docker image from Docker Hub. It handles environment variables and Docker execution automatically.

## Prerequisites

- Docker installed and running
- Access to Docker Hub
- PostgreSQL database (if using external database)

## Quick Start

### Basic Usage

```bash
./run_obp_docker.sh
```

### Pull Latest Image

```bash
./run_obp_docker.sh --pull
# or
./run_obp_docker.sh -p
```

## Configuration

### Environment Variables

The script uses the following environment variables with their default values:

#### Core Configuration
- `OBP_CONNECTOR`: Database connector type (default: `mapped`)
- `OBP_HOSTNAME`: API hostname (default: `http://localhost:8080`)
- `OBP_DB_URL`: Database connection string (default: `jdbc:postgresql://host.docker.internal:5433/obpapi?user=postgres&password=1`)
- `AUTH_USER_SKIP_EMAIL_VALIDATION`: Skip email validation (default: `true`)

#### Super Admin Configuration
- `SUPER_ADMIN_USERNAME`: Admin username (default: `admin`)
- `SUPER_ADMIN_PASSWORD`: Admin password (default: `admin123456`)
- `SUPER_ADMIN_EMAIL`: Admin email (default: `admin@example.com`)
- `SUPER_ADMIN_USER_IDS`: Admin user IDs (default: `26170288-5311-4eef-b878-838b46d0496c`)

### Custom Configuration

You can override any of these variables by setting them before running the script:

```bash
export OBP_HOSTNAME="https://your-domain.com"
export OBP_DB_URL="jdbc:postgresql://your-db-host:5432/obpapi?user=youruser&password=yourpass"
./run_obp_docker.sh
```

## Docker Command Details

The script runs the following Docker command:

```bash
docker run --rm -it \
    -p 8080:8080 \
    -e "OBP_CONNECTOR=$OBP_CONNECTOR" \
    -e "OBP_HOSTNAME=$OBP_HOSTNAME" \
    -e "OBP_DB_URL=$OBP_DB_URL" \
    -e "OBP_AUTHUSER_SKIPEMAILVALIDATION=$AUTH_USER_SKIP_EMAIL_VALIDATION" \
    -e "OBP_SUPER_ADMIN_USER_IDS=$SUPER_ADMIN_USER_IDS" \
    --add-host="host.docker.internal:host-gateway" \
    openbankproject/obp-api
```

### Port Mapping
- The API will be available on `http://localhost:8080`

### Network Configuration
- `--add-host="host.docker.internal:host-gateway"` allows the container to access services running on the host machine

## Troubleshooting

### Docker Not Running
If you see the error "Docker is not running", ensure Docker Desktop is started.

### Database Connection Issues
- Verify your PostgreSQL database is running
- Check the connection string in `OBP_DB_URL`
- Ensure the database is accessible from the Docker container

### Permission Issues
Make sure the script is executable:
```bash
chmod +x run_obp_docker.sh
```

## Security Notes

⚠️ **Important Security Considerations:**

1. **Default Credentials**: The script uses default admin credentials. Change these in production:
   ```bash
   export SUPER_ADMIN_PASSWORD="your-secure-password"
   ```

2. **Database Credentials**: Update the database connection string with secure credentials:
   ```bash
   export OBP_DB_URL="jdbc:postgresql://host:port/db?user=secureuser&password=securepass"
   ```

3. **Email Validation**: Consider enabling email validation in production:
   ```bash
   export AUTH_USER_SKIP_EMAIL_VALIDATION="false"
   ```

## API Access

Once the container is running, you can access:
- **API Documentation**: `http://localhost:8080/api-docs`
- **API Endpoints**: `http://localhost:8080/obp/v5.1.0/`
- **Admin Interface**: Use the super admin credentials to access administrative functions

## Stopping the Container

The container will stop when you press `Ctrl+C` in the terminal where it's running. The `--rm` flag ensures the container is automatically removed after stopping.
