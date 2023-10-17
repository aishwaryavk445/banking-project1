pipeline {
    agent any
    tags {
      Name = "test-server"
         }
    environment {
        AWS_ACCESS_KEY_ID       = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY   = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
        stage('Checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/aishwaryavk445/banking-project1.git'
            }
        }
        stage('Build Package') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('HTML Reports') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking-project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t aishwaryavk445/banking-project1:1.0 .'
            }
        }
        stage('Docker Push Image') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'docker_password', usernameVariable: 'docker_login')]) {
               sh 'docker login -u ${docker_login} -p ${docker_password}'
                  }
               sh 'docker push aishwaryavk445/banking-project:1.0'      
            }
        }
        stage('Configure Server with terraform and deploy using Ansible') {
          steps {
             dir('my-serverfiles') {
             sh 'sudo chmod 600 Awskeypair.pem'
             sh 'terraform init'
             sh 'terraform validate'
             sh 'terraform apply --auto-approve'
                }
             }
         }
        }
      }
    
