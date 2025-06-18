
# 🚀 End-to-End DevOps Implementation for Azure Web Deployment

![CI/CD](https://img.shields.io/badge/CI/CD-Jenkins-blue) ![IaC](https://img.shields.io/badge/IaC-Terraform-9cf) ![Ansible](https://img.shields.io/badge/CM-Ansible-green) ![Azure](https://img.shields.io/badge/Cloud-Azure-blue)

## 📘 Project Overview

This project demonstrates a complete DevOps pipeline using **Terraform**, **Ansible**, and **Jenkins**, automating the provisioning, configuration, and deployment of a static web application on **Azure Cloud**.

> 🔧 The entire pipeline can be executed with a single Jenkins click.

---

## 📌 Objectives

- Provision Azure infrastructure using Terraform
- Configure web server using Ansible
- Deploy a static web app (`index.html`) to the server
- Trigger everything via Jenkins Pipeline
- Showcase Infrastructure as Code (IaC) and Continuous Deployment

---

## 🧰 Tech Stack

| Tool       | Purpose                              |
|------------|--------------------------------------|
| **Terraform** | Infrastructure provisioning on Azure |
| **Ansible**   | Web server installation & app deployment |
| **Jenkins**   | CI/CD orchestration via pipeline      |
| **Azure**     | Host cloud infrastructure             |
| **GitHub**    | Version control & source storage      |
| **Docker**    | Jenkins runs in Docker container      |

---

## 🏗️ Project Structure

```
final-devops-project/
├── terraform/             # Terraform IaC code
│   ├── main.tf
│   └── variables.tf
├── ansible/               # Ansible playbooks
│   ├── install_web.yml
│   └── inventory.ini
├── app/                   # Static web content
│   └── index.html
├── Jenkinsfile            # CI/CD Pipeline definition
└── README.md              # You're reading it!
```

---

## ⚙️ Jenkins Pipeline Stages

| Stage                            | Description                                     |
|----------------------------------|-------------------------------------------------|
| 🔄 **Checkout Code**             | Clones GitHub repo                              |
| 🌍 **Terraform Init/Apply**      | Provisions Azure VM                             |
| 🛠️ **Ansible Install Web**       | Installs Apache and deploys index.html          |
| ✅ **Verify Web App**            | Curl the public IP to check deployment          |

---

## 📥 How to Run (Manually)

1. **Clone the Repo**
   ```bash
   git clone https://github.com/rehmatwadii/final-devops-project.git
   cd final-devops-project
   ```

2. **Provision Azure VM using Terraform**
   ```bash
   cd terraform
   terraform init
   terraform apply -auto-approve
   ```

3. **Run Ansible Playbook**
   ```bash
   cd ../ansible
   ansible-playbook install_web.yml -i <VM-IP>, -u azureuser --private-key ~/.ssh/devops_key
   ```

4. **Verify**
   ```bash
   curl http://<VM-IP>
   ```

---

## 📸 Sample Screenshots
✅ 1. Terraform Setup & Verification
📸 Screenshot: terraform init
cd terraform
terraform init
 
________________________________________
📸 Screenshot: terraform validate
terraform validate
 
________________________________________
📸 Screenshot: terraform plan
terraform plan
 
________________________________________
📸 Screenshot: terraform apply
terraform apply -auto-approve
 
________________________________________
✅ 2. Azure Resource Verification
📸 Screenshot: Show VM Public IP (after apply)
az vm list-ip-addresses -g jenkins-rg -n devops-vm -o table
 
________________________________________






📸 Screenshot: Azure CLI Login Status
az account show
 
________________________________________
✅ 3. SSH into Azure VM
📸 Screenshot: SSH Access to VM
ssh -i ~/.ssh/devops_key azureuser@172.190.195.253
 ________________________________________
📸 Screenshot: Check Apache is Running on VM
sudo systemctl status apache2
 
________________________________________
✅ 4. Ansible Configuration Management
📸 Screenshot: Run Ansible Playbook
cd ansible
ansible-playbook install_web.yml -i 172.190.195.253, -u azureuser --private-key ~/.ssh/devops_key
 
________________________________________
✅ 6. Jenkins Pipeline Execution
 
      
________________________________________



✅ 7. GitHub Version Control
📸 Screenshot: Git Commit History
git log --oneline –graph
 
________________________________________
📸 Screenshot: Folder Structure
tree -L 2
  ________________________________________
📸 Screenshot: Git Status
git status
 
 
________________________________________















✅ 8. System & Path Diagnostics
📸 Screenshot: Show All Project Paths
Pwd
ls -la
 
________________________________________
📸 Screenshot: SSH Key Details
ls -la ~/.ssh/
cat ~/.ssh/devops_key.pub
 
________________________________________

---

## 🧠 Lessons Learned

- Proper SSH key handling and path resolution is crucial
- Jenkins path issues often arise in Docker + WSL
- Terraform’s `file()` requires exact path precision
- Ansible playbooks must be run with the correct inventory and key

---

## 🔧 Troubleshooting

| Issue | Fix |
|-------|-----|
| SSH key not found in Jenkins | Ensure `devops_key.pub` is present in repo |
| Ansible can't find index.html | Use `{{ playbook_dir }}/../app/index.html` |
| Terraform can't read key | Use absolute or correctly resolved relative path |

---

## 🚀 Future Improvements

- Add remote backend for Terraform state (e.g., Azure Storage)
- Implement monitoring (Prometheus + Grafana or Azure Monitor)
- Add test automation for deployment verification
- Use Ansible roles for better reusability

---

## 🤝 Author

**Muhammad Rehmatullah Wadi Wala**  
🎓 Final Year Student – SZABIST University  
🌐 [GitHub Profile](https://github.com/rehmatwadii)

---

## 📝 License

This project is for educational purposes only.
