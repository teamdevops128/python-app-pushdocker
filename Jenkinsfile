pipeline {
    agent any
    environment{
        DOCKER_IMAGE_NAME = 'mypythonimage2'
        DOCKERFILE_PATH = 'Dockerfile'
        CONTAINER_NAME= 'pythonv22'
        DOCKER_CREDENTIAL_ID = 'DOCKER'
        DOCKER_REGISTRY = 'docker.io'
        
    }
    stages {
        stage('checkout'){
            steps{
                git 'https://github.com/rudravasu2021/DockerApp.git'
                
            }
        }
        stage('DockerBuild') {
            steps {
                script{
                    docker.build("nitinjoshicancerian20/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}" , "-f ${DOCKERFILE_PATH} .")
                }
            }
        }
        stage('run conatiner'){
            steps{
                script{
                    // Check if the container exists
                    def containerExists = sh(script: "docker ps -a --format '{{.Names}}' | grep ${CONTAINER_NAME}", returnStatus: true)
                    
                    // Stop and remove the existing container if it exists
                    if (containerExists == 0) {
                        sh "docker stop ${CONTAINER_NAME}"
                        sh "docker rm ${CONTAINER_NAME}"
                    }
                    sh "docker run -d -p 8980:5000 --name ${CONTAINER_NAME} nitinjoshicancerian20/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }
        stage('Security Scan') {
            steps {
                script {
                    def trivyOutput = sh(script: "trivy image nitinjoshicancerian20/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}", returnStdout: true).trim()

                    echo "Trivy Scan Results:\n${trivyOutput}"

                    if (trivyOutput.contains("high vulnerabilities")) {
                        error "High vulnerabilities found. Build failed."
                    }
                }
            }
        }
  stage('Push Docker Image') {
            steps {
                script {
                    // Authenticate with Docker registry using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIAL_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        def dockerAuth = "--username=${DOCKER_USERNAME} --password-stdin"
                        sh "echo ${DOCKER_PASSWORD} | docker login ${DOCKER_REGISTRY} ${dockerAuth}"

                        
                        // Push Docker image to registry
                        sh "docker push ${DOCKER_REGISTRY}/nitinjoshicancerian20/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"

                        // Logout from Docker registry
                        sh "docker logout ${DOCKER_REGISTRY}"
                    }
                }
            }
 }
     
     
        
}
}
