# Azure Windows Server Lab

## 🌍 Inclusive and Global: Welcome to Windows Server 2025 Feature Testing!

This repository offers a **ready-to-use, Azure-based lab** for exploring the features of Windows Server in a **mixed-mode domain environment**. Whether you're an IT professional, developer, or educator, this project provides a practical and efficient way to learn, experiment, and test innovations in Windows Server.

The goal is to give you a simple platform for testing and experimenting with Windows Server 2025. This solution was built using Microsoft proven practices from the following sources:

- [Microsoft Cloud Adoption Framework for Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)
- [Microsoft Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/)
- [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/architecture/framework/)

---

## 🎯 Project Overview

### **Name:** Azure Windows Server Lab

### **Short Description:**
Easily deploy an Azure-based lab to explore mixed-mode domain configurations with Windows Server 2022 and 2025 using Bicep, Template Specs, and Azure CLI. You should be able to take the pilot environment in many different ways as you experiment with the new operating system release.

### **Purpose:**
- Provide an **MVP-ready** lab environment for Windows Server testing.
- Support a **mixed-mode domain** with multiple Windows Server versions.
- Enable **modular deployments** using **Bicep**.
- Utilize **Template Specs** for reusable and versioned infrastructure.
- Promote best practices in Azure architecture, GitHub workflows, and documentation.

### **Audience:**
- IT Professionals
- Developers
- Educators
- Enthusiasts

---

## 🚀 Features

1. **Azure-Based Infrastructure:**
   - Single VNet with two subnets:
     - **Server Subnet:** Hosts Domain Controllers and member servers.
     - **Client Subnet:** Hosts clients or fallback server-based clients.

2. **Mixed-Mode Domain Configuration:**
   - Supports multiple Windows Server versions as Domain Controllers.
   - Includes member servers and fallback clients.

3. **Bicep-Powered Deployment:**
   - Modular Bicep templates for VNet, NSGs, VMs, and more.
   - Centralized variables for quick customization.

4. **Template Specs for Versioning:**
   - Publish Bicep templates as Template Specs for reusability and consistency.
   - Easily manage versioned deployments.

5. **GitHub Excellence:**
   - CI/CD workflows with build badges.
   - Comprehensive and beautifully structured README.
   - Inclusive and mindful design.

6. **Global Inclusivity:**
   - Designed to accommodate diverse users worldwide.
   - Written with clear, accessible language.

---

## 🛠️ Getting Started

### **Prerequisites**

1. **Azure Subscription:** [Sign up for free](https://azure.microsoft.com/free/).
2. **Azure CLI:** Ensure the Azure CLI is installed. If not, [install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

---

### Deployment Instructions

#### Universal Deployment Using Azure CLI

Run the following commands to deploy the lab:

```bash
# Clone the repository
git clone https://github.com/timothywarner/azure-windows-server-lab.git
cd azure-windows-server-lab

# Validate Bicep templates (optional)
az bicep build --file bicep/main.bicep

# Deploy the main Bicep template
az deployment sub create \
  --template-file bicep/main.bicep \
  --parameters @bicep/parameters.json

Deploying with Template Specs
To use Template Specs for deployment:

bash
Copy code
# Publish the Bicep template as a Template Spec
az ts create \
  --name AzureWindowsServerLab \
  --version 1.0 \
  --resource-group <resource-group-name> \
  --location <location> \
  --template-file bicep/main.bicep

# Deploy using the Template Spec
az deployment group create \
  --resource-group <resource-group-name> \
  --template-spec /subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.Resources/templateSpecs/AzureWindowsServerLab/versions/1.0
🔗 Competition and Inspirations
Existing Projects:
MSLab: A resource for Hyper-V environments.
AdaptiveCloudLabKit: Focused on Azure Stack HCI.
Windows Server on Hyper-V: Hyper-V-centric testing environment.
This lab builds upon the best ideas from these projects while offering a cloud-native, Azure-focused solution.

💡 Why Template Specs?
Version Control: Simplifies updates and rollbacks with versioned templates.
Reusability: Share Template Specs across teams for consistent deployments.
Integration with CI/CD: Supports automated workflows for publishing and testing templates.
🧠 Variables and Customization
All deployment variables are centralized in parameters.json for ease of use. Modify them to:

Adjust region or resource names.
Configure the VM sizes and OS images.
📜 License
This project is licensed under the MIT License.

✍️ Contributions
All contributions are welcome! Please follow the Contributing Guide to submit your ideas, bug fixes, or improvements.

📣 Community
Join the discussion and share your feedback on:

GitHub Issues
Contact Information
🌟 Acknowledgements
Special thanks to the global community of IT pros, developers, and educators who inspire innovation every day. Together, let's embrace the future of Windows Server!

To-Do List:

 Develop and test Bicep templates for various deployment scenarios.
 Create detailed documentation for setup and configuration.
 Implement CI/CD workflows with GitHub Actions.
 Publish and manage Template Specs for all infrastructure components.
 Explore additional features like hybrid cloud scenarios and advanced security configurations.








