pipeline {
    agent {label 'Slave_A'}

    environment {
        DOCKER_IMAGE = 'varun1411/java_cicd'
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
    }
}

