pipeline {
    agent {
        docker {
            // Gunakan image Maven resmi tanpa "-dind"
            image 'maven:3.9.9-eclipse-temurin-17'
            // Mount Docker socket agar bisa build & run container
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -v /root/.m2:/root/.m2'
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
                if [ "$(docker ps -q -f name=${IMAGE_NAME})" ]; then
                  docker stop ${IMAGE_NAME} && docker rm ${IMAGE_NAME}
                fi
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
