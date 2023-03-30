pipeline {
  agent any
  tools {
    nodejs '19.8.1'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/dev']], userRemoteConfigs: [[url: 'https://github.com/SheltonChin/FotoPie-Front-end.git']]])
      }
    }
    stage('Build') {
      steps {
        sh 'npm install'
        withCredentials([string(credentialsId: 'BACKEND_API', variable: 'BACKEND_API'), string(credentialsId: 'BACKEND_PORT', variable: 'BACKEND_PORT')]) {
          sh 'npm run build'
        }
      }
    }

    stage('Export') {
      steps {
        sh 'npm run export'
      }
    }

    
    stage('Terraform Init') {
      steps {
        script {
          env.TF_ACTION_WORKING_DIR = '.'
          withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform init'
          }
        }
      }
    }
    stage('Terraform Apply') {
      steps {
        script {
          env.TF_ACTION_WORKING_DIR = '.'
          withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh 'aws s3 sync ./out s3://jenkins-gohusky'
        }
      }
    }
  }
}
