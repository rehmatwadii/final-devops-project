pipeline {
  agent any
  options {
    timeout(time: 1, unit: 'HOURS')  // Prevent infinite hangs
    disableConcurrentBuilds()         // Avoid overlapping runs
    retry(3)                         // Auto-retry on failure
  }

  environment {
    ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
    ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
    ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
    ANSIBLE_HOST_KEY_CHECKING = 'False'  // Disable SSH host verification
  }

  stages {
    stage('Checkout Code') {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: [[name: '*/main']],
          extensions: [],
          userRemoteConfigs: [[url: 'https://github.com/rehmatwadii/final-devops-project.git']]
        )
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          sh '''
          terraform apply -auto-approve -input=false
          sleep 30  # Wait for VM to fully initialize
          '''
        }
      }
    }

    stage('Ansible Setup') {
      steps {
        script {
          VM_PUBLIC_IP = sh(
            script: 'terraform -chdir=terraform output -raw public_ip',
            returnStdout: true
          ).trim()
          
          // Verify SSH connectivity first
          sh "ssh-keyscan ${VM_PUBLIC_IP} >> ~/.ssh/known_hosts"
        }
      }
    }

    stage('Deploy Web App') {
      steps {
        script {
          ansiblePlaybook(
            playbook: 'ansible/install_web.yml',
            inventory: "${VM_PUBLIC_IP},",
            credentialsId: 'devops-ssh-key',
            extras: '-v --private-key=./terraform/devops_key'
          )
        }
      }
    }

    stage('Verify Deployment') {
      steps {
        script {
          def response = sh(
            script: "curl -sSf http://${VM_PUBLIC_IP}",
            returnStatus: true
          )
          if (response != 0) {
            error("Web app verification failed!")
          } else {
            echo "Web app is running successfully"
          }
        }
      }
    }
  }

  post {
    always {
      echo "Cleaning up workspace..."
      deleteDir()
    }
    failure {
      slackSend channel: '#devops-alerts',
                message: "Build ${currentBuild.fullDisplayName} failed!"
    }
  }
}
