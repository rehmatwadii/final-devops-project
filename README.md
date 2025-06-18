
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
---
✅ 1. Terraform Setup & Verification
![image](https://github.com/user-attachments/assets/3988dc3b-53b6-4fe2-9e71-ba1b28be4413)
📸 Screenshot: terraform validate
![image](https://github.com/user-attachments/assets/81833d4b-be56-4448-8baf-eea55fa2dda0)
📸 Screenshot: terraform plan
![image](https://github.com/user-attachments/assets/19443ec9-6799-4513-b8f1-1aad894e6542)
📸 Screenshot: terraform apply
![image](https://github.com/user-attachments/assets/a30efa01-0f42-4f7f-96b6-b5eca4fcfbf3)
✅ 2. Azure Resource Verification
📸 Screenshot: Show VM Public IP (after apply)
![image](https://github.com/user-attachments/assets/b6874529-f109-4acf-8d15-cdf29efa4ab8)
📸 Screenshot: Azure CLI Login Status
![image](https://github.com/user-attachments/assets/ea278106-4355-45db-be0c-6fc6b5c6fe66)
✅ 3. SSH into Azure VM
📸 Screenshot: SSH Access to VM
![image](https://github.com/user-attachments/assets/4e72d367-d592-4bdc-aa21-83d08c71ee77)
📸 Screenshot: Check Apache is Running on VM
![image](https://github.com/user-attachments/assets/7ae1bfe9-557b-41c2-b99d-81a9611e724a)
✅ 4. Ansible Configuration Management
📸 Screenshot: Run Ansible Playbook
![image](https://github.com/user-attachments/assets/145cc085-040c-4c43-87ff-57d0c0e13f28)
✅ 6. Jenkins Pipeline Execution
![image](https://github.com/user-attachments/assets/3ab91491-68d1-4509-8e60-5a23e53ea5d7)
![image](https://github.com/user-attachments/assets/f1e240f5-1bf7-458a-8e70-f6349d3b9d7a)
![image](https://github.com/user-attachments/assets/78219f95-d5d4-4d2f-a756-fd892dd6a3da)
![image](https://github.com/user-attachments/assets/b4243438-a62d-4e9a-9055-ea94705c6763)
![image](https://github.com/user-attachments/assets/24fa2cd4-277d-4b4a-a1e1-2f43ae61e633)
![image](https://github.com/user-attachments/assets/473a8e80-a12d-40db-8e6a-9c29322b4a96)
![image](https://github.com/user-attachments/assets/9107c75b-74c1-4ccd-98e6-cd87fedf43f5)
✅ 7. GitHub Version Control
📸 Screenshot: Git Commit History
![image](https://github.com/user-attachments/assets/9b96bc56-b0ed-430e-9171-7625cbd15f3b)
📸 Screenshot: Folder Structure
![image](https://github.com/user-attachments/assets/98d20813-b825-45b2-a609-73de20c28724)
📸 Screenshot: Git Status
![image](https://github.com/user-attachments/assets/65b45aca-f3df-4458-b3b4-45717a4b296c)
![image](https://github.com/user-attachments/assets/14e8703c-a4a9-43a5-a8e3-7251d6c505d4)
✅ 8. System & Path Diagnostics
📸 Screenshot: Show All Project Paths
![image](https://github.com/user-attachments/assets/4c9f5b3e-48b8-4182-a708-b775c0cda372)
📸 Screenshot: SSH Key Details
![image](https://github.com/user-attachments/assets/5ce3291f-b9fe-404d-8a8b-9b1c2cda2e6d)

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
