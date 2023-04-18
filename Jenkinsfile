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

       stage('Deploy') {
            steps {
                echo 'Deploying'
                sshagent(['web-server-key']) {
                    sh '$CONNECT curl -X GET http://admin:nexuspass@34.239.129.2:8081/repository/career-repo/webapp.zip --output webapp.zip'
                    sh '$CONNECT curl -X GET http://admin:nexuspass@34.239.129.2:8081/repository/career-repo/connect.php --output connect.php'
                    sh '$CONNECT "curl ifconfig.io"'
                    sh '$CONNECT "sudo apt install zip -y"'
                    sh '$CONNECT "rm -rf /var/www/html/"'
                    sh '$CONNECT "mkdir /var/www/html/"'
                    //sh '$CONNECT "unzip /home/ubuntu/webapp.zip -d /varhome/ubuntu/app"'
                    sh '$CONNECT "unzip webapp.zip -d /var/www/html/"'
                    sh '$CONNECT "rm /var/www/html/config/connect.php"'
                    sh '$CONNECT "cp /home/ubuntu/connect.php /var/www/html/config/"'
                    //sh '$CONNECT "sudo sh /var/www/html/database/test-db.sh"'
                    
                    // sh '$CONNECT "cp -r /home/ubuntu/app/. /var/www/html/"'
                    
                }
            }
        }

        stage('Clean-Up') {
            steps {
                echo 'Remove existing files'
                sshagent(['web-server-key']) {
                    sh '$CONNECT "sudo rm /home/ubuntu/webapp.zip"'
                    sh '$CONNECT "sudo rm /home/ubuntu/connect.php"'
                }
            }
        }  
    
    }
}
