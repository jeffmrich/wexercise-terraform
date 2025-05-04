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
                echo "Running normal build steps..."
                // Add your build logic here
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: '68c7bc8f-e9cd-4c7c-a7bd-50216fe4bb4d',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       sh 'cd terraform && terraform init'
                   }
            }
        }
        stage('terraform destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                echo "Running terraform destroy..."
                // Add your destroy logic here
                   withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                   credentialsId: '68c7bc8f-e9cd-4c7c-a7bd-50216fe4bb4d',
                   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                       sh 'cd terraform && terraform destroy --auto-approve'
                   }
            } 
        }
    }
}
