pipeline {
    agent any
    
    environment {
        IS_DOCKERIMAGE = """${sh(
            returnStatus: true,
            script: 'docker image inspect hello-world > /dev/null'
        )}"""
    }

    stages {
        stage('Prepare') {
            when { expression { IS_DOCKERIMAGE == '1' } }
            steps {
                sh "docker build -t hadoop-build-env:latest hadoop-ci/hadoop-build-env/Dockerfile"
            }
        }
        stage('Build') {
            steps {
                sh "docker build -o out hadoop-ci/Dockerfile"
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy Stage"
            }
        }
    }
}