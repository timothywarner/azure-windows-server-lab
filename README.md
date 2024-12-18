# Azure Windows Server Lab

## 🌍 Inclusive and Global: Welcome to Windows Server 2025 Feature Testing!

This repository offers a **ready-to-use, Azure-based lab** for exploring the features of Windows Server in a **mixed-mode domain environment**. Whether you're an IT professional, developer, or educator, this project provides a practical and efficient way to learn, experiment, and test innovations in Windows Server.

The goal is to give you a simple platform for testing and experimenting with Windows Server 2025. This solution was built using Microsoft proven practices from the following sources:

- Microsoft Cloud Deployment Framework for Azure
- Microsoft Azure Architecture Center
- Microsoft Azure Well-Architected Framework

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
2. **Azure CLI:** The deployment scripts will guide you to install it if not present.

### Deployment Instructions

#### Windows WSL 2/macOS/Linux

Run the following commands:
```bash
# Navigate to the repo directory
cd azure-windows-server-lab

# Execute the deployment script
./scripts/deploy.sh
