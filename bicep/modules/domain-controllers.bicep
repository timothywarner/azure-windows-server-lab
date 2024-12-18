param location string
param namePrefix string
param environmentName string
param subnetId string
param keyVaultName string
param tags object

@secure()
param adminPassword string

var dc1Name = '${namePrefix}-dc1'
var dc2Name = '${namePrefix}-dc2'

// Common VM configuration
var vmConfig = {
  size: 'Standard_D2s_v3'  // 2 vCPUs, 8GB RAM - good for lab DCs
  publisher: 'MicrosoftWindowsServer'
  offer: 'WindowsServer'
  sku: '2022-datacenter-azure-edition'  // Will update to 2025 when available
  version: 'latest'
}

// Network Interfaces
resource dc1Nic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: '${dc1Name}-nic'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '10.0.0.4'  // First DC
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

resource dc2Nic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: '${dc2Name}-nic'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '10.0.0.5'  // Second DC
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

// Virtual Machines
resource dc1 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: dc1Name
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmConfig.size
    }
    osProfile: {
      computerName: dc1Name
      adminUsername: 'labadmin'
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: vmConfig.publisher
        offer: vmConfig.offer
        sku: vmConfig.sku
        version: vmConfig.version
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: dc1Nic.id
        }
      ]
    }
  }
}

resource dc2 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: dc2Name
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmConfig.size
    }
    osProfile: {
      computerName: dc2Name
      adminUsername: 'labadmin'
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: vmConfig.publisher
        offer: vmConfig.offer
        sku: vmConfig.sku
        version: vmConfig.version
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: dc2Nic.id
        }
      ]
    }
  }
}

// Primary DC configuration
module dc1Config 'dc-config.bicep' = {
  name: 'dc1-config'
  params: {
    vmName: dc1.name
    location: location
    domainName: domainName
    safeModePassword: adminPassword
    isPrimary: true
    tags: tags
  }
  dependsOn: [
    dc1
  ]
}

// Secondary DC configuration - wait for primary DC
module dc2Config 'dc-config.bicep' = {
  name: 'dc2-config'
  params: {
    vmName: dc2.name
    location: location
    domainName: domainName
    safeModePassword: adminPassword
    isPrimary: false
    domainAdminPassword: adminPassword
    tags: tags
  }
  dependsOn: [
    dc2
    dc1Config
  ]
}

output dc1Name string = dc1.name
output dc2Name string = dc2.name 
