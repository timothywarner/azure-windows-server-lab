param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,
    
    [Parameter(Mandatory=$true)]
    [SecureString]$DomainAdminPassword,
    
    [Parameter(Mandatory=$true)]
    [SecureString]$SafeModePassword
)

# Install AD DS Role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Create credential object for domain join
$credential = New-Object System.Management.Automation.PSCredential ("${DomainName}\labadmin", $DomainAdminPassword)

# Promote as additional DC
Import-Module ADDSDeployment
Install-ADDSDomainController `
    -DomainName $DomainName `
    -Credential $credential `
    -SafeModeAdministratorPassword $SafeModePassword `
    -InstallDns:$true `
    -NoGlobalCatalog:$false `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -NoRebootOnCompletion:$false `
    -Force:$true 