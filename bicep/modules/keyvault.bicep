param location string
param namePrefix string
param environmentName string
param tags object
param objectId string

var keyVaultName = '${namePrefix}-${environmentName}-kv'

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: false
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: objectId
        permissions: {
          secrets: [
            'get'
            'list'
            'set'
            'delete'
          ]
          keys: [
            'get'
            'list'
            'create'
            'delete'
          ]
          certificates: [
            'get'
            'list'
            'create'
            'delete'
          ]
        }
      }
    ]
  }
}

output keyVaultName string = keyVaultName
