pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-2'
        ECR_REPO = '418272766940.dkr.ecr.eu-west-2.amazonaws.com'
        IMAGE_NAME = 'java-app-repo'
        GIT_CREDENTIALS_ID = 'github-ssh-cred'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    IMAGE_TAG = "${env.BUILD_NUMBER}"
                    sh "docker build -t ${ECR_REPO}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO}"
                    sh "docker push ${ECR_REPO}/${IMAGE_NAME}:${env.BUILD_NUMBER}"
                }
            }
        }
        stage('Clone Infrastructure Repo') {
            steps {
                sshagent (credentials: [env.GIT_CREDENTIALS_ID]) {
                    withCredentials([string(credentialsId: "infra-repo-url-secret", variable: 'INFRA_REPO_URL_SECRET')]) {
                        script {
                            sh """
                                git clone ${INFRA_REPO_URL_SECRET} infrastructure-${env.BUILD_NUMBER}
                            """
                        }
                    }
                }
            }
        }
        stage('Update Helm values.yml') {
            steps {
                script {
                    sh """
                        cd infrastructure-${env.BUILD_NUMBER}/ && sed -i 's/^\\( *tag: *\\).*/\\1${env.BUILD_NUMBER}/' helm-chart/values.yaml
                    """
                }
            }
        }
        stage('Commit and Push Changes') {
            steps {
            sshagent (credentials: [env.GIT_CREDENTIALS_ID]) {
                sh """
                cd infrastructure-${env.BUILD_NUMBER}/
                git config user.email "ci-bot@hawk.ai"
                git config user.name "CI Bot"
                git add helm-chart/values.yaml
                git commit -m "Update image tag to ${env.BUILD_NUMBER} [ci skip]" || echo "No changes to commit"
                git push origin HEAD:main
                """
            }
            }
        }
    }
}