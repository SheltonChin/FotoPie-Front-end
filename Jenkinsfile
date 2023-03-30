pipeline {
  agent any
  environment {
    BACKEND_API = credentials('secrets.BACKEND_API')
    BACKEND_PORT = credentials('secrets.BACKEND_PORT')
    AWS_ACCESS_KEY_ID = credentials('secrets.aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('secrets.aws-secret-access-key')
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
    stage('Export') {
      steps {
        sh 'npm run export'
      }
    }     
    stage('Test') {
      steps {
        sh 'npm run test'
      }
    }
    stage('Deploy') {
      steps {
        withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
        sh 'aws s3 sync ./out s3://jenkins-gohusky'
         }
        }
      }
    }
  }
}
