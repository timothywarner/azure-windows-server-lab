param location string
param namePrefix string
param environmentName string
param networkConfig object
param tags object

var vnetName = '${namePrefix}-${environmentName}-vnet'
var serverSubnetName = 'ServerSubnet'
var clientSubnetName = 'ClientSubnet'
var bastionSubnetName = 'AzureBastionSubnet'
var bastionHostName = '${namePrefix}-${environmentName}-bastion'
var bastionPublicIPName = '${bastionHostName}-ip'

// Deploy Server NSG
module serverNsg 'nsg.bicep' = {
  name: 'serverNsgDeployment'
  params: {
    location: location
    namePrefix: namePrefix
    environmentName: environmentName
    tags: tags
    nsgType: 'server'
  }
}

// Deploy Client NSG
module clientNsg 'nsg.bicep' = {
  name: 'clientNsgDeployment'
  params: {
    location: location
    namePrefix: namePrefix
    environmentName: environmentName
    tags: tags
    nsgType: 'client'
  }
}

// Public IP for Bastion
resource bastionPublicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: bastionPublicIPName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        networkConfig.vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: serverSubnetName
        properties: {
          addressPrefix: networkConfig.serverSubnetPrefix
          networkSecurityGroup: {
            id: serverNsg.outputs.nsgId
          }
        }
      }
      {
        name: clientSubnetName
        properties: {
          addressPrefix: networkConfig.clientSubnetPrefix
          networkSecurityGroup: {
            id: clientNsg.outputs.nsgId
          }
        }
      }
      {
        name: bastionSubnetName
        properties: {
          addressPrefix: networkConfig.bastionSubnetPrefix
        }
      }
    ]
  }
}

// Azure Bastion Host
resource bastionHost 'Microsoft.Network/bastionHosts@2023-05-01' = {
  name: bastionHostName
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/${bastionSubnetName}'
          }
          publicIPAddress: {
            id: bastionPublicIP.id
          }
        }
      }
    ]
  }
}

output vnetName string = vnet.name
output vnetId string = vnet.id
output serverSubnetId string = vnet.properties.subnets[0].id
output clientSubnetId string = vnet.properties.subnets[1].id
output bastionHostName string = bastionHost.name
