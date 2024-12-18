# Azure Windows Server Lab Environment

This project deploys a Windows Server lab environment in Azure using Bicep templates. The environment includes:

- A virtual network with proper subnets and security rules
- An Azure Key Vault for secret management
- Two Windows Server 2022 domain controllers in an Active Directory forest

## Prerequisites

- Azure subscription
- Azure CLI or Azure PowerShell
- Contributor access to the target subscription
- A service principal or managed identity for deployment (for Key Vault access)

## Architecture

The deployment creates the following resources:
- Resource Group
- Virtual Network with subnet for servers
- Network Security Group with rules for RDP and Active Directory
- Azure Key Vault for storing secrets
- Two Windows Server 2022 VMs configured as domain controllers

## Deployment Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/azure-windows-server-lab.git
   cd azure-windows-server-lab
   ```

2. Update the parameters file:
   - Open `bicep/parameters.json`
   - Update values according to your requirements
   - Set the `deploymentPrincipalId` to your deployment identity's Object ID

3. Deploy using Azure CLI:
   ```bash
   # Login to Azure
   az login

   # Set your subscription
   az account set --subscription "Your Subscription Name"

   # Deploy the Bicep template
   az deployment sub create \
     --name WindowsServerLab \
     --location eastus \
     --template-file bicep/main.bicep \
     --parameters @bicep/parameters.json \
     --parameters adminPassword="YourSecurePassword"
   ```

   Or using Azure PowerShell:
   ```powershell
   # Login to Azure
   Connect-AzAccount

   # Set your subscription
   Set-AzContext -Subscription "Your Subscription Name"

   # Deploy the Bicep template
   New-AzDeployment `
     -Name WindowsServerLab `
     -Location eastus `
     -TemplateFile bicep/main.bicep `
     -TemplateParameterFile bicep/parameters.json `
     -adminPassword (ConvertTo-SecureString -String "YourSecurePassword" -AsPlainText -Force)
   ```

## Post-Deployment

After deployment:
1. Connect to DC1 using RDP
2. Verify Active Directory installation
3. Connect to DC2 and verify domain join
4. Configure additional AD settings as needed

## Security Notes

- The deployment uses a secure parameter for the admin password
- NSG rules are configured for basic AD functionality
- Key Vault is used for secret management
- Update the admin password immediately after deployment
- Consider implementing Azure Bastion for secure RDP access

## Contributing

Feel free to submit issues and enhancement requests!








