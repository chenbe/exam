pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'exam-v1', description: 'Branch to be built')
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                script {
                    dockerImage = docker.build("counter-service:\${BRANCH_NAME}", "-f Dockerfile .")
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to Production...'
               
            }
        }
        stage('Post-Deployment Test') {
            steps {
                echo 'Running Post-Deployment Tests...'
             
            }
        }
    }
}

