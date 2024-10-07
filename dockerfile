pipeline {
    agent any // Use any available agent

    parameters {
        string(name: 'BRANCH_TYPE', defaultValue: 'development', description: 'Select the branch type')
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from repository...'
                // Checkout your SCM repository here (e.g., Git)
                // git 'https://github.com/your/repo.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'
                // Add your build commands here
                // e.g., sh './build.sh'
            }
        }

        stage('Test') {
            steps {
                script {
                    if (params.BRANCH_TYPE == 'development') {
                        echo 'Running development tests...'
                        // Add development test commands here
                        // e.g., sh './dev_tests.sh'
                    } else if (params.BRANCH_TYPE == 'production') {
                        echo 'Running production tests...'
                        // Add production test commands here
                        // e.g., sh './prod_tests.sh'
                    } else {
                        error "Unknown branch type: ${params.BRANCH_TYPE}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (params.BRANCH_TYPE == 'development') {
                        echo 'Deploying to the development environment...'
                        // Add your deployment commands for development
                        // e.g., sh './deploy_dev.sh'
                    } else if (params.BRANCH_TYPE == 'production') {
                        echo 'Deploying to the production environment...'
                        // Add your deployment commands for production
                        // e.g., sh './deploy_prod.sh'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Perform any cleanup actions here
        }
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
}
