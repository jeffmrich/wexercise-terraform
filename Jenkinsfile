pipeline {
    agent any
    parameters {
        choice(
            name: 'ACTION',
            choices: ['build', 'destroy'],
            description: 'Choose pipeline action: build (default) or destroy'
        )
    }
    stages {
        stage('Set Action for Webhook') {
            when {
                not { triggeredBy 'UserIdCause' }
            }
            steps {
                script {
                    // If triggered by GitHub (not manual), force ACTION to 'build'
                    env.ACTION = 'build'
                    echo "Triggered by webhook. ACTION set to 'build'."
                }
            }
        }
        stage('Checkout') {
            when {
                expression { params.ACTION == 'build' }
            }
            steps {
              checkout scm
            }
        }
        stage('terraform init') {
            when {
                expression { params.ACTION == 'build' }
            }
            steps {
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: 'b2a7bcce-5b43-48e9-a8e3-ea75faa01903',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       dir('terraform') {
                           sh 'terraform init'
                       } 
                   }
            }
        }
        stage('terraform validate') {
            when {
                expression { params.ACTION == 'build' }
            }
            steps {
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: 'b2a7bcce-5b43-48e9-a8e3-ea75faa01903',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       dir('terraform') {
                           sh 'terraform validate'
                       } 
                   }
            }
        }
        stage('terraform plan') {
            when {
                expression { params.ACTION == 'build' }
            }
            steps {
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: 'b2a7bcce-5b43-48e9-a8e3-ea75faa01903',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       dir('terraform') {
                           sh 'terraform plan -out=/tmp/tfplan'
                       } 
                   }
            }
        }
        stage('terraform apply') {
            when {
                expression { params.ACTION == 'build' }
            }
            steps {
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: 'b2a7bcce-5b43-48e9-a8e3-ea75faa01903',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       dir('terraform') {
                           sh 'terraform apply --auto-approve /tmp/tfplan'
                       } 
                   }
            }
        }
        stage('terraform destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: 'b2a7bcce-5b43-48e9-a8e3-ea75faa01903',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       dir('terraform') {
                           sh 'terraform destroy --auto-approve'
                       } 
                   }
            } 
        }
    }
}
