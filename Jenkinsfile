pipeline {
    agent any

    environment {
        NODE_OPTIONS = "--openssl-legacy-provider"
        CI = "false"
        IMAGE = "nodepm2box:latest"  // Change this if your Docker image name is different
        CONTAINER_NAME = "trading-ui-app"
    }

    stages {
        stage('Checkout Source') {
            steps {
                git 'https://github.com/Saikiranbit/Trading-UI.git'
            }
        }

        stage('Build & Start in Docker') {
            steps {
                script {
                    // Cleanup any previous container
                    sh """
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    """

                    // Build your custom image (if needed)
                    sh """
                        docker build -t $IMAGE .
                    """

                    // Run the container with PM2 start
                    sh """
                        docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE \
                        sh -c '
                            echo SKIP_PREFLIGHT_CHECK=true > .env &&
                            npm install &&
                            npm run build &&
                            pm2 --name Trading-UI start npm -- start &&
                            pm2 logs
                        '
                    """
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Build failed!'
        }
        success {
            echo '✅ Build succeeded and app is running inside Docker with PM2!'
        }
    }
}
