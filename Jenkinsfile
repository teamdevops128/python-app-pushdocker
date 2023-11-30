pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'pythonimage'
        DOCKERFILE_PATH = 'Dockerfile'
        CONTAINER_NAME = 'pythonapp'
        DOCKER_CREDENTIAL_ID = 'DOCKER'
        DOCKER_REGISTRY = 'docker.io'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/teamdevops128/python-app.git'
            }
        }
    
        stage('DockerBuild') {
            steps {
                script{
                    def dockerTag = "nitinjoshicancerian20/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
                    docker.build(dockerTag, "-f ${DOCKERFILE_PATH} .") 
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
