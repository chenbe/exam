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
                    def sanitizedBranchName = BRANCH_NAME.replaceAll("[^a-zA-Z0-9_.-]", "-")
                    dockerImage = docker.build("counter-service:${sanitizedBranchName}", "-f Dockerfile .")
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

