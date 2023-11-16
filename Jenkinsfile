pipeline {
    agent any

    parameters {
        //BRANCH_NAME is defined in the job as Extended choise parameter
        string(name: 'EXTERNAL_IP', defaultValue: '3.218.247.223', description: 'The public IP to check that the web service is working') 
    }

    stages {
        stage('Cleanup') {
            steps {
                script {
                    // Sanitize the branch name
                    def sanitizedBranchName = BRANCH_NAME.replaceAll("[^a-zA-Z0-9_.-]", "-")
                    def imageName = 'counter-service:${BRANCH_NAME}'
                    // Stop and remove containers based on the image name
                    sh "docker ps -q --filter ancestor=${imageName} | xargs -r docker stop"
                    sh "docker ps -a -q --filter ancestor=${imageName} | xargs -r docker rm"
                    // Remove the Docker image tagged with the branch name
                    sh "docker rmi -f counter-service:${sanitizedBranchName} || true"
                }
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                script {
                    def sanitizedBranchName = BRANCH_NAME.replaceAll("[^a-zA-Z0-9_.-]", "-")
                    dockerImage = docker.build("counter-service:${sanitizedBranchName}", "-f Dockerfile .")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh "docker run --rm --name counter-service -d -p 80:80 counter-service:${BRANCH_NAME}"
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                script {
                    // Sleep for 10 seconds before checking the service
                    sleep(time: 10, unit: 'SECONDS')
                    def response = sh(script: "curl -f http://${params.EXTERNAL_IP}:80/ || echo 'Service not ready'", returnStdout: true).trim()
                    if (response.contains('Service not ready')) {
                        error("Service is not up and running")
                    }
                    else {
                        echo "Service is up and running"
                    }
                }
            }
        }

    }
}
