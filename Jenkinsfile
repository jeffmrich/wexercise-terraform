pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('terraform init') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: '68c7bc8f-e9cd-4c7c-a7bd-50216fe4bb4d',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'cd terraform && terraform init'
        }
      }
    }
    stage('terraform validate') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: '68c7bc8f-e9cd-4c7c-a7bd-50216fe4bb4d',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh 'cd terraform && terraform validate'
        }
      }
    }
  }
  parameters {
    booleanParam(name: 'APPLY_CHANGES', defaultValue: false, description: 'Apply changes?')
  }
}
