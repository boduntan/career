pipeline {
    agent any
    environment {
        SSH_CRED = credentials('web-server-key')
        def CONNECT = 'ssh -o StrictHostKeyChecking=no ubuntu@ec2-15-222-239-156.ca-central-1.compute.amazonaws.com'
    }
    stages {
        
        stage('Build') {
            steps {
                echo 'packaging app'
                sh "ls"
                sh "pwd"
                sh "zip -r webapp.zip ."
            }
        }
    
        stage('Package') {
            steps {
                echo 'upload artifacts'
                sh "curl -v -u admin:nexuspass --upload-file webapp.zip http://34.239.129.2:8081/repository/career-repo/webapp.zip"
            }
        }
        
    
    }
}
