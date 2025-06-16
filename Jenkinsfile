pipeline {
  agent any

  environment {
    ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
    ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
    ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
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
        sh '''
        VM_PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)
        ansible-playbook -i "${VM_PUBLIC_IP}," --private-key ./terraform/devops_key ansible/install_web.yml
        '''
      }
    }

    stage('Verify App') {
      steps {
        sh '''
        VM_PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)
        curl http://${VM_PUBLIC_IP}
        '''
      }
    }
  }
}
