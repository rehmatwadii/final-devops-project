pipeline {
    agent any

    environment {
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/rehmatwadii/final-devops-project.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Ansible Install Web') {
            steps {
                script {
                    // ✅ FIXED: Correct output variable name
                    def VM_PUBLIC_IP = sh(script: 'terraform -chdir=terraform output -raw public_ip_address', returnStdout: true).trim()
                    echo "VM Public IP: ${VM_PUBLIC_IP}"

                    // Run Ansible Playbook
                    sh "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${VM_PUBLIC_IP},' ansible/install_web.yml"
                }
            }
        }

        stage('Verify App') {
            steps {
                script {
                    def VM_PUBLIC_IP = sh(script: 'terraform -chdir=terraform output -raw public_ip_address', returnStdout: true).trim()
                    echo "Verifying app at http://${VM_PUBLIC_IP}"
                    sh "curl http://${VM_PUBLIC_IP}"
                }
            }
        }
    }
}
