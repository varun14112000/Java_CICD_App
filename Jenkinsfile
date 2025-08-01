pipeline {
    agent {
        label 'Slave_A' // adjust to your actual agent label
    }

    environment {
        DOCKER_IMAGE = "varun1411/java_cicd:latest"
        CONTAINER_NAME = "java_cicd_app_container"
    }

    tools {
        maven 'mymvn'     // Set in Jenkins tools config     
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/varun14112000/Java_CICD_App.git', branch: 'main'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    // Stop and remove if container already exists
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    // Run new container
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }
}

