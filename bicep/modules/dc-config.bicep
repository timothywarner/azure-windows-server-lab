param vmName string
param location string
param domainName string
@secure()
param safeModePassword string
param isPrimary bool
@secure()
param domainAdminPassword string = ''
param tags object
param scriptStorageUri string

resource dcConfig 'Microsoft.Compute/virtualMachines/extensions@2023-07-01' = {
  name: '${vmName}/DCPromo'
  location: location
  tags: tags
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        isPrimary ? 
          '${scriptStorageUri}/configure-dc.ps1' :
          '${scriptStorageUri}/configure-secondary-dc.ps1'
      ]
    }
    protectedSettings: {
      commandToExecute: isPrimary ?
        'powershell.exe -ExecutionPolicy Unrestricted -File configure-dc.ps1 -DomainName ${domainName} -SafeModePassword ${safeModePassword}' :
        'powershell.exe -ExecutionPolicy Unrestricted -File configure-secondary-dc.ps1 -DomainName ${domainName} -DomainAdminPassword ${domainAdminPassword} -SafeModePassword ${safeModePassword}'
    }
  }
} 
