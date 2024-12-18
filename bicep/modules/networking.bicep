param location string
param namePrefix string
param environmentName string
param tags object

// Variables
var vnetName = '${namePrefix}-${environmentName}-vnet'
var vnetAddressPrefix = '10.0.0.0/16'
var serverSubnetName = 'ServerSubnet'
var serverSubnetPrefix = '10.0.0.0/24'
var clientSubnetName = 'ClientSubnet'
var clientSubnetPrefix = '10.0.1.0/24'

// Network Security Groups
resource serverNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: '${serverSubnetName}-nsg'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowRDP'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowADPorts'
        properties: {
          priority: 1100
          access: 'Allow'
          direction: 'Inbound'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRanges: ['53', '88', '135', '389', '445', '464', '636', '3268-3269']
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: serverSubnetName
        properties: {
          addressPrefix: serverSubnetPrefix
          networkSecurityGroup: {
            id: serverNsg.id
          }
        }
      }
      {
        name: clientSubnetName
        properties: {
          addressPrefix: clientSubnetPrefix
        }
      }
    ]
  }
}

// Outputs
output vnetName string = vnet.name
output vnetId string = vnet.id
output serverSubnetId string = vnet.properties.subnets[0].id
output clientSubnetId string = vnet.properties.subnets[1].id 
