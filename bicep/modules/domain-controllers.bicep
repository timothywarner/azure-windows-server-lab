param location string
param namePrefix string
param environmentName string
param subnetId string
param keyVaultName string
param vmConfig object
param networkConfig object
@secure()
param adminPassword string
param domainName string
param tags object

var dc1Name = '${namePrefix}-${environmentName}-dc1'
var dc2Name = '${namePrefix}-${environmentName}-dc2'

// Deploy first domain controller
module dc1 'vm.bicep' = {
  name: 'dc1Deployment'
  params: {
    location: location
    vmName: dc1Name
    subnetId: subnetId
    vmSize: vmConfig.vmSize
    adminUsername: vmConfig.adminUsername
    adminPassword: adminPassword
    tags: tags
  }
}

// Deploy second domain controller
module dc2 'vm.bicep' = {
  name: 'dc2Deployment'
  params: {
    location: location
    vmName: dc2Name
    subnetId: subnetId
    vmSize: vmConfig.vmSize
    adminUsername: vmConfig.adminUsername
    adminPassword: adminPassword
    tags: tags
  }
}

// Install AD DS on DC1
resource dc1Config 'Microsoft.Compute/virtualMachines/extensions@2023-07-01' = {
  name: '${dc1Name}/InstallADDS'
  location: location
  dependsOn: [
    dc1
  ]
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.compute/vm-domain-controller/DSC/CreateADPDC.ps1'
      ]
      commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File CreateADPDC.ps1 -DomainName ${domainName} -AdminCreds ${vmConfig.adminUsername} -SafeModeAdminCreds ${vmConfig.adminUsername}'
    }
    protectedSettings: {
      commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File CreateADPDC.ps1 -DomainName ${domainName} -AdminCreds ${vmConfig.adminUsername} -SafeModeAdminCreds ${vmConfig.adminUsername} -AdminPassword ${adminPassword} -SafeModeAdminPassword ${adminPassword}'
    }
  }
}

// Join DC2 to domain
resource dc2Config 'Microsoft.Compute/virtualMachines/extensions@2023-07-01' = {
  name: '${dc2Name}/JoinDomain'
  location: location
  dependsOn: [
    dc2
    dc1Config
  ]
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.compute/vm-domain-controller/DSC/PrepareADBDC.ps1'
      ]
      commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File PrepareADBDC.ps1 -DomainName ${domainName} -AdminCreds ${vmConfig.adminUsername}'
    }
    protectedSettings: {
      commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File PrepareADBDC.ps1 -DomainName ${domainName} -AdminCreds ${vmConfig.adminUsername} -AdminPassword ${adminPassword}'
    }
  }
}

output dc1Name string = dc1Name
output dc2Name string = dc2Name
