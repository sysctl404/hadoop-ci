pipeline {
    agent any
    
    environment {
        IS_DOCKERIMAGE = """${sh(
            returnStatus: true,
            script: 'docker image inspect hadoop-build-env > /dev/null'
        )}"""
        IS_HADOOP_DISTR = fileExists '/opt/hadoop-dist/hadoop-3.1.3.tar.gz'
    }

    stages {
        stage('Prepare env') {
            when { expression { IS_DOCKERIMAGE == '1' } }
            steps {
                echo "hadoop-build-env image is not available, start building env..."
                sh "docker build -t hadoop-build-env:latest hadoop-build-env > dockerbuild.log"
            }
        }
        stage('Build') {
            when { expression { IS_HADOOP_DISTR == 'false' } }
            steps {
                echo "start building hadoop..."
                sh "DOCKER_BUILDKIT=1 docker build -o /opt/hadoop-dist ."
            }
        }
        stage('Deploy') {
            steps {
                echo "deploying hadoop to localhost..."
                sh "sudo tar xvf /opt/hadoop-dist/hadoop-3.1.3.tar.gz -C /opt"
                sh "sudo cp config/core-site.xml /opt/hadoop-3.1.3/etc/hadoop/core-site.xml"
                sh "sudo cp config/hdfs-site.xml /opt/hadoop-3.1.3/etc/hadoop/hdfs-site.xml"
                sh "sudo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 /opt/hadoop-3.1.3/bin/hdfs namenode -format -force"
            }
        }
    }
}