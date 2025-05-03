pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh 'pwd'
        sh 'ls -l'
      }
    }
    stage('terraform init') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: '68c7bc8f-e9cd-4c7c-a7bd-50216fe4bb4d',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'pwd'
            sh 'terraform init'
        }
      }
    }
  }
  parameters {
    booleanParam(name: 'APPLY_CHANGES', defaultValue: false, description: 'Apply changes?')
  }
}
