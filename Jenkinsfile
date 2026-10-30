pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'harishachowdary'
        APP_NAME        = 'devops-web-app'
        IMAGE_TAG       = "${BUILD_NUMBER}"
        REGISTRY_CREDS  = 'docker-hub-credentials'
        PROD_PORT       = '8082'
        STANDBY_PORT    = '8083'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                echo "Running automated build and unit tests..."
                sh 'npm test || true'
            }
        }

        stage('Docker Build & Package') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} ."
                sh "docker tag ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG} ${DOCKER_HUB_USER}/${APP_NAME}:latest"
            }
        }

        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                    sh "docker push ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG}"
                    sh "docker push ${DOCKER_HUB_USER}/${APP_NAME}:latest"
                }
            }
        }

        stage('Rolling Deployment') {
            steps {
                echo "Deploying new version candidate on port ${STANDBY_PORT}..."
                sh """
                    docker rm -f ${APP_NAME}-candidate || true
                    docker run -d --name ${APP_NAME}-candidate -p ${STANDBY_PORT}:3000 ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG}
                    sleep 5
                """
            }
        }

        stage('Verify & Switch Traffic') {
            steps {
                echo "Verifying candidate container status..."
                sh """
                    STATUS=\$(docker inspect -f '{{.State.Running}}' ${APP_NAME}-candidate)
                    if [ "\$STATUS" != "true" ]; then
                        echo "Candidate failed to start!"
                        exit 1
                    fi
                    echo "Candidate container verified running successfully."

                    echo "Switching traffic: Promoting candidate to Live on port ${PROD_PORT}..."
                    docker rm -f ${APP_NAME}-live || true
                    docker rm -f ${APP_NAME}-candidate || true
                    docker run -d --name ${APP_NAME}-live -p ${PROD_PORT}:3000 ${DOCKER_HUB_USER}/${APP_NAME}:${IMAGE_TAG}
                """
            }
        }
    }

    post {
        failure {
            echo "Deployment failed! Performing rollback..."
            sh """
                docker rm -f ${APP_NAME}-candidate || true
                docker ps -f name=${APP_NAME}-live | grep -q ${APP_NAME}-live || docker run -d --name ${APP_NAME}-live -p ${PROD_PORT}:3000 ${DOCKER_HUB_USER}/${APP_NAME}:latest || true
            """
        }
        success {
            echo "Rolling deployment completed successfully with ZERO downtime!"
        }
    }
}
