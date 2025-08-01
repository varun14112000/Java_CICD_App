pipeline {
    agent {label 'Slave_A'}

    environment {
        DOCKER_IMAGE = 'varun1411/java-cicd-app'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/your-java-repo.git'
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
                DOCKER_HUB_CREDENTIALS = credentials('docker-hub-creds')  // Jenkins Credentials ID
            }
            steps {
                sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }
    }
}

