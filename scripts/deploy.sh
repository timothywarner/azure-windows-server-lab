#!/bin/bash

# Generate a secure password
ADMIN_PASSWORD=$(openssl rand -base64 16)

# Deploy the infrastructure
az deployment sub create \
  --name "wslab-deployment-$(date +%Y%m%d-%H%M%S)" \
  --location eastus2 \
  --template-file bicep/main.bicep \
  --parameters @bicep/parameters.json \
  --parameters adminPassword=$ADMIN_PASSWORD

# Output the deployment name for reference
echo "Deployment completed. Check Azure Portal for details."
