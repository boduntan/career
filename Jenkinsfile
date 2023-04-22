pipeline {
    agent any
    environment {
        SSH_CRED = credentials('web-app-key')
        def CONNECT = 'ssh -o StrictHostKeyChecking=no ubuntu@ec2-3-96-155-39.ca-central-1.compute.amazonaws.com'
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
        
        stage('Deploy') {
            steps {
                echo 'Deploying'
                sshagent(['web-app-key']) {
                    sh 'scp -o StrictHostKeyChecking=no -i $SSH_CRED webapp.zip ubuntu@ec2-3-96-155-39.ca-central-1.compute.amazonaws.com'
                    sh '$CONNECT "curl ifconfig.io"'
                    sh '$CONNECT "sudo apt install zip -y"'
                    sh '$CONNECT "rm -rf /var/www/html/"'
                    sh '$CONNECT "sudo mkdir -p /var/www/html/"'
                    sh '$CONNECT "unzip /var/lib/jenkins/workspace/web-app/webapp.zip -d /var/www/html/"'
                    sh '$CONNECT "rm /var/www/html/config/connect.php"'
                    sh '$CONNECT "cp /home/ubuntu/connect.php /var/www/html/config/"'
                    sh '$CONNECT "sudo sh /var/www/html/database/test-db.sh"'
                    sh '$CONNECT "cp -r /home/ubuntu/app/. /var/www/html/"'
                    
                }
            }
        }

        stage('Clean-Up') {
            steps {
                echo 'Remove existing files'
                sshagent(['web-app-key']) {
                    sh '$CONNECT "sudo rm /home/ubuntu/webapp.zip"'
                }
            }
        }
    }
}