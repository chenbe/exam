pipeline {
    agent any
    
    environment {
        // Define an environment variable to hold the image name
        DOCKER_IMAGE = ''
    }

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'exam-v1', description: 'Branch to be built')
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                script {
                    def sanitizedBranchName = BRANCH_NAME.replaceAll("[^a-zA-Z0-9_.-]", "-")
                    env.DOCKER_IMAGE = 'counter-service:v1'
                    dockerImage = docker.build("counter-service:${sanitizedBranchName}", "-f Dockerfile .")
                    //println dockerImage.inspect()
                    //env.DOCKER_IMAGE = dockerImage.id
                    //println("Docker Image ID: ${env.DOCKER_IMAGE}")
                }
                echo "Docker Image ID: ${env.DOCKER_IMAGE}"
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Pull the image if it's not built locally
                    // sh 'docker pull my-image-name:my-tag'

                    // Run the Docker container
                    sh "docker run --name counter-service-chen -d -p 80:80 counter-service:exam-v1"
                    //sudo docker run -d -p 80:80 counter-service
                    //--name my-container -d ${env.DOCKER_IMAGE}"


                    // You can add additional commands here to interact with the container
                    // For example, sh 'docker exec my-container some-command'
                }
            }
        }

        stage('Post-Deployment Test') {
            steps {
                echo 'Running Post-Deployment Tests...'
             
            }
        }
    }
}


