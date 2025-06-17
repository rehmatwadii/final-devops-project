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
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/rehmatwadii/final-devops-project.git']]
                ])
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
                    VM_PUBLIC_IP = sh(script: 'terraform -chdir=terraform output -raw public_ip', returnStdout: true).trim()
                    sh """
                        ansible-playbook -i "${VM_PUBLIC_IP}," --private-key ./terraform/devops_key ansible/install_web.yml
                    """
                }
            }
        }

        stage('Verify App') {
            steps {
                script {
                    VM_PUBLIC_IP = sh(script: 'terraform -chdir=terraform output -raw public_ip', returnStdout: true).trim()
                    sh "curl http://${VM_PUBLIC_IP}"
                }
            }
        }
    }
}
