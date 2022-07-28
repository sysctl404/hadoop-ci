pipeline {
    agent any
    
    environment {
        IS_DOCKERIMAGE = """${sh(
            returnStatus: true,
            script: 'docker image inspect hadoop-build-env > /dev/null'
        )}"""
    }

    stages {
        stage('Prepare') {
            when { expression { IS_DOCKERIMAGE == '1' } }
            steps {
                sh "docker build -t hadoop-build-env:latest hadoop-build-env"
            }
        }
        stage('Build') {
            steps {
                sh "docker build -o ../hadoop ."
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy Stage"
            }
        }
    }
}