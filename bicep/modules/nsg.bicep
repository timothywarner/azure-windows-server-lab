param location string
param namePrefix string
param environmentName string
param tags object
param nsgType string = 'server' // 'server' or 'client'

var nsgName = '${namePrefix}-${environmentName}-${nsgType}-nsg'

var serverInboundRules = [
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
    name: 'AllowDNS'
    properties: {
      priority: 1100
      access: 'Allow'
      direction: 'Inbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRanges: ['53']
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
  {
    name: 'AllowKerberos'
    properties: {
      priority: 1200
      access: 'Allow'
      direction: 'Inbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRanges: ['88', '464']
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
  {
    name: 'AllowLDAP'
    properties: {
      priority: 1300
      access: 'Allow'
      direction: 'Inbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRanges: ['389', '636', '3268-3269']
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
  {
    name: 'AllowSMB'
    properties: {
      priority: 1400
      access: 'Allow'
      direction: 'Inbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRanges: ['445']
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
  {
    name: 'AllowRPC'
    properties: {
      priority: 1500
      access: 'Allow'
      direction: 'Inbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRanges: ['135', '49152-65535']
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
]

var serverOutboundRules = [
  {
    name: 'AllowDNSOutbound'
    properties: {
      priority: 1000
      access: 'Allow'
      direction: 'Outbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRange: '53'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
  {
    name: 'AllowInternetOutbound'
    properties: {
      priority: 1100
      access: 'Allow'
      direction: 'Outbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRange: '*'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: 'Internet'
    }
  }
]

var clientInboundRules = [
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
]

var clientOutboundRules = [
  {
    name: 'AllowDomainServices'
    properties: {
      priority: 1000
      access: 'Allow'
      direction: 'Outbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRanges: ['53', '88', '389', '445', '636']
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
    }
  }
  {
    name: 'AllowInternetOutbound'
    properties: {
      priority: 1100
      access: 'Allow'
      direction: 'Outbound'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRange: '*'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: 'Internet'
    }
  }
]

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    securityRules: concat(
      nsgType == 'server' ? serverInboundRules : clientInboundRules,
      nsgType == 'server' ? serverOutboundRules : clientOutboundRules
    )
  }
}

output nsgId string = nsg.id
output nsgName string = nsg.name
