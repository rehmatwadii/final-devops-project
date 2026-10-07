pipeline {
    agent { label 'linux' }
    options {
        disableConcurrentBuilds()
        skipDefaultCheckout(true)
        timestamps()
        timeout(time: 45, unit: 'MINUTES')
    }
    parameters {
        string(name: 'SSH_ALLOWED_CIDR', defaultValue: '', description: 'Jenkins egress IPv4 /32')
    }
    environment {
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
        TF_IN_AUTOMATION = 'true'
        TF_INPUT = 'false'
        TF_VAR_ssh_allowed_cidr = "${params.SSH_ALLOWED_CIDR}"
        ANSIBLE_CONFIG = "${WORKSPACE}/ansible/ansible.cfg"
    }
    stages {
        stage('Checkout') { steps { checkout scm } }
        stage('Init') {
            steps {
                withCredentials([file(credentialsId: 'terraform-backend', variable: 'BACKEND_CONFIG')]) {
                    sh 'terraform -chdir=terraform init -input=false -backend-config="$BACKEND_CONFIG"'
                }
            }
        }
        stage('Format and Validate') {
            steps { sh 'terraform -chdir=terraform fmt -check && terraform -chdir=terraform validate' }
        }
        stage('Plan') {
            steps {
                withCredentials([file(credentialsId: 'vm-ssh-public-key', variable: 'PUBLIC_KEY')]) {
                    sh 'sh scripts/plan.sh'
                }
            }
        }
        stage('Approve Changes') {
            steps { input message: 'Review the plan above. Apply these Azure changes?' }
        }
        stage('Apply') { steps { sh 'terraform -chdir=terraform apply -input=false deploy.tfplan' } }
        stage('Retrieve Target') {
            steps {
                script {
                    env.VM_IP = sh(script: 'terraform -chdir=terraform output -raw public_ip_address', returnStdout: true).trim()
                    env.VM_USER = sh(script: 'terraform -chdir=terraform output -raw admin_username', returnStdout: true).trim()
                    if (!(env.VM_IP ==~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) || !(env.VM_USER ==~ /[a-z][a-z0-9_-]*/)) {
                        error('Invalid target outputs')
                    }
                }
            }
        }
        stage('Wait for SSH and Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'vm-ssh', keyFileVariable: 'SSH_KEY')]) {
                    sh 'sh scripts/deploy.sh'
                }
            }
        }
        stage('Verify') {
            steps { sh 'sh scripts/verify.sh' }
        }
    }
    post {
        always { sh 'rm -f terraform/deploy.tfplan known_hosts' }
        failure { echo 'Deployment failed; infrastructure retained for diagnosis.' }
        success { echo 'Application and health response verified.' }
    }
}
