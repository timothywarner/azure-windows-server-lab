# Azure Windows Server Lab

## 🌍 Inclusive and Global: Welcome to the Future of Windows Server Testing

This repository offers a **ready-to-use, Azure-based lab** for exploring the features of Windows Server in a **mixed-mode domain environment**. Whether you're an IT professional, developer, or educator, this project provides a practical and efficient way to learn, experiment, and test innovations in Windows Server.

---

## 🎯 Project Overview

### **Name:** Azure Windows Server Lab

### **Short Description:**
Easily deploy an Azure-based lab to explore mixed-mode domain configurations with Windows Server 2022 and 2025 using Bicep and Azure best practices.

### **Purpose:**
- Provide an **MVP-ready** lab environment for Windows Server testing.
- Support a **mixed-mode domain** with multiple Windows Server versions.
- Enable **modular deployments** using **Bicep**.
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

4. **GitHub Excellence:**
   - CI/CD workflows with build badges.
   - Comprehensive and beautifully structured README.
   - Inclusive and mindful design.

5. **Global Inclusivity:**
   - Designed to accommodate diverse users worldwide.
   - Written with clear, accessible language.

---

## 🛠️ Getting Started

### **Pre-Requisites**

1. **Azure Subscription:** [Sign up for free](https://azure.microsoft.com/free/).
2. **Azure CLI:** Install and configure. Use the included deployment script to check and install it if needed.
3. **GitHub Account:** Clone or fork this repository to get started.

### **Quick Start**

```bash
# Clone the repository
git clone https://github.com/timothywarner/azure-windows-server-lab.git
cd azure-windows-server-lab

# Deploy the lab
az deployment sub create --template-file main.bicep --parameters @parameters.json
```

---

## 🔗 Competition and Inspirations

### **Existing Projects:**
- [MSLab](https://github.com/microsoft/MSLab): A resource for Hyper-V environments.
- [AdaptiveCloudLabKit](https://github.com/thomasmaurer/AdaptiveCloudLabKit): Focused on Azure Stack HCI.
- [Windows Server on Hyper-V](https://github.com/Curious4Tech/Windows-Server-on-Hyper-V): Hyper-V-centric testing environment.

This lab builds upon the best ideas from these projects while offering a **cloud-native, Azure-focused solution.**

---

## 💡 Why Bicep?

- **Native Azure Integration:** Simplifies deployment with seamless Azure Resource Manager (ARM) integration.
- **Human-Readable Syntax:** Makes infrastructure as code accessible to everyone.
- **Modularity:** Supports easy customization and scalability.

---

## 🧠 Variables and Customization

All deployment variables are centralized in `parameters.json` for ease of use. Modify them to:
- Adjust region or resource names.
- Configure the VM sizes and OS images.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## ✍️ Contributions

All contributions are welcome! Please follow the [Contributing Guide](CONTRIBUTING.md) to submit your ideas, bug fixes, or improvements.

---

## 📣 Community

Join the discussion and share your feedback on:
- [GitHub Issues](https://github.com/timothywarner/azure-windows-server-lab/issues)
- [Contact Information](https://timw.info/az104)

---

## 🌟 Acknowledgements

Special thanks to the global community of IT pros, developers, and educators who inspire innovation every day. Together, let's embrace the future of Windows Server!

---

**To-Do List:**

- [ ] Develop and test Bicep templates for various deployment scenarios.
- [ ] Create detailed documentation for setup and configuration.
- [ ] Implement CI/CD workflows with GitHub Actions.
- [ ] Gather community feedback and iterate on features.
- [ ] Explore additional features like hybrid cloud scenarios and advanced security configurations.

---

