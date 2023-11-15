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
                script {
                    echo "2"
                    // Deployment steps, e.g., pushing the image to a registry, 
                    // deploying to a server, or deploying to a Kubernetes cluster
                }
            }
        }
        stage('Post-Deployment Test') {
            steps {
                echo 'Running Post-Deployment Tests...'
                script {
                    echo "3"
                    // Add your post-deployment testing steps here
                }
            }
        }
    }
}

