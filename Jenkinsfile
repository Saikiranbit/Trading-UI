pipeline {
    agent any

    environment {
        NODE_OPTIONS = "--openssl-legacy-provider"
        CI = "false"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Saikiranbit/Trading-UI.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t trading-ui:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f trading-ui || true
                    docker run -d -p 3000:3000 --name trading-ui trading-ui:latest
                '''
            }
        }
    }

    post {
        success {
            echo '✅ App built and running in Docker!'
        }
        failure {
            echo '❌ Something went wrong.'
        }
    }
}
