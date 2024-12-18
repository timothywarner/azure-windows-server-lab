targetScope = 'subscription'

// Parameters from parameters.json
param location string
param environmentName string
param namePrefix string
param domainName string
param vmConfig object
param networkConfig object
param deploymentPrincipalId string

// Secure parameter for VM admin password (to be provided at deployment time)
@secure()
param adminPassword string

var resourceGroupName = '${namePrefix}-${environmentName}-rg'
var tags = {
  Environment: environmentName
  Project: 'Windows Server Lab'
  Purpose: 'Solution Accelerator'
  DeploymentDate: '2023-10-01'
}

// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Key Vault for storing secrets
module keyVault 'modules/keyvault.bicep' = {
  scope: rg
  name: 'keyVaultDeployment'
  params: {
    location: location
    namePrefix: namePrefix
    environmentName: environmentName
    tags: tags
    objectId: deploymentPrincipalId
  }
}

// Store admin password in Key Vault
resource adminPasswordSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'vmAdminPassword'
  properties: {
    value: adminPassword
  }
}

// Networking
module networking 'modules/networking.bicep' = {
  scope: rg
  name: 'networkingDeployment'
  params: {
    location: location
    namePrefix: namePrefix
    environmentName: environmentName
    networkConfig: networkConfig
    tags: tags
  }
}

// Domain Controllers
module domainControllers 'modules/domain-controllers.bicep' = {
  scope: rg
  name: 'domainControllersDeployment'
  params: {
    location: location
    namePrefix: namePrefix
    environmentName: environmentName
    subnetId: networking.outputs.serverSubnetId
    keyVaultName: keyVault.outputs.keyVaultName
    vmConfig: vmConfig
    networkConfig: networkConfig
    adminPassword: adminPassword
    domainName: domainName
    tags: tags
  }
}

output keyVaultName string = keyVault.outputs.keyVaultName
output dc1Name string = domainControllers.outputs.dc1Name
output dc2Name string = domainControllers.outputs.dc2Name
