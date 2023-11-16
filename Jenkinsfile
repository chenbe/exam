pipeline {
    agent any

    parameters {
        //string(name: 'BRANCH_NAME', defaultValue: 'exam-v1', description: 'Branch to be built')
        // Active Choices script is more limited in pipeline and may not work as expected
        def BRANCH_NAME = [] // Placeholder for dynamic branches
        try {
            def stdout = new ByteArrayOutputStream()
            def stderr = new ByteArrayOutputStream()
            def cmd = "git ls-remote --heads git@github.com:chenbe/exam.git".execute()
            cmd.consumeProcessOutput(stdout, stderr)
            cmd.waitForOrKill(10000) // wait max 10 seconds
            if(cmd.exitValue() == 0) {
                BRANCH_NAME = stdout.toString().trim().split("\n").collect { it.split()[1].replaceAll('refs/heads/', '') }
             }
        } catch (Exception e) {
            BRANCH_NAME = ["Error: ${e.message}"]
        }
        BRANCH_NAME.each {
            activeChoiceParam("${it}") {
                description("Select a branch")
                scriptlerScriptPath('path/to/your/script.groovy') // Use if you have a scriptler script
                choiceType("SINGLE_SELECT")
            }
        }
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

        stage('Check The Service') {
            steps {
                echo 'Running Post-Deployment Tests...'
            
            }
        }
    }
}
