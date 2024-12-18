param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,
    
    [Parameter(Mandatory=$true)]
    [SecureString]$SafeModePassword
)

# Install AD DS Role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Configure as first DC in new forest
Import-Module ADDSDeployment
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "WinThreshold" `
    -DomainName $DomainName `
    -ForestMode "WinThreshold" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -SafeModeAdministratorPassword $SafeModePassword `
    -Force:$true 