# Ensure Azure CLI is installed and logged in
$azVersion = az version | ConvertFrom-Json
if (-not $azVersion) {
    Write-Error "Azure CLI is required. Please install from https://aka.ms/installazurecli"
    exit 1
}

# Generate a secure password
$securePassword = ConvertTo-SecureString (-join ((33..126) | Get-Random -Count 16 | ForEach-Object { [char]$_ })) -AsPlainText -Force
$adminPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

# Deploy the infrastructure
$deploymentName = "wslab-deployment-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
az deployment sub create `
    --name $deploymentName `
    --location eastus2 `
    --template-file bicep/main.bicep `
    --parameters @bicep/parameters.json `
    --parameters adminPassword=$adminPassword

# Clear sensitive variables
$adminPassword = $null
$securePassword.Dispose()

Write-Host "Deployment completed. Check Azure Portal for details."
Write-Host "Admin password has been stored in Key Vault" 