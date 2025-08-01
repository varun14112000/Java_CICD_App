pipeline {
    agent {label 'Slave_A'}
    tools {
        maven 'mymvn'
    }
    environment {
        DOCKER_IMAGE = 'varun1411/java_cicd'
        CONTAINER_IMAGE = 'java_cicd_container'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main' , url: 'https://github.com/varun14112000/Java_CICD_App.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }
        stage('Push to Docker Hub') {
            environment {
                DOCKER_HUB_CREDENTIALS = credentials('dockerhub-creds')  // Jenkins Credentials ID
            }
            steps {
                sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }
        stage('Deploy Application') {
            steps {
                script {
                    // Stop & remove container if it exists
                    sh "docker stop $CONTAINER_NAME || true"
                    sh "docker rm $CONTAINER_NAME || true"
                    
                    // Run the container
                    sh "docker run -d --name $CONTAINER_NAME -p 3000:8080 $IMAGE_NAME"
                }
            }
        }
    }
}

