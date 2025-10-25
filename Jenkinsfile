pipeline {
    agent {
        docker {
            image 'maven:3.9.9-eclipse-temurin-17-dind'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        IMAGE_NAME = "digital-clock"
        IMAGE_TAG = "latest"
        PORT = "9090"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                echo '🔧 Building JAR with Maven...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running container...'
                sh '''
                docker ps -q --filter "name=${IMAGE_NAME}" | grep -q . && docker stop ${IMAGE_NAME} && docker rm ${IMAGE_NAME} || true
                docker run -d -p ${PORT}:${PORT} --name ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Build and deployment successful!'
        }
        failure {
            echo '❌ Build failed. Please check logs.'
        }
    }
}
