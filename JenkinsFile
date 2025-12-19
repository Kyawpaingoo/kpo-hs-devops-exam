pipeline{
    agent any
    tools{
        nodejs "nodejs24"
    }
    stages{
        stage('Install Dependencies'){
            steps{
                sh 'npm install'
            }
        }
        stage('Run Tests'){
            steps{
                sh 'npm run test'
            }
        }
        stage('Enable Permission to Service File') {
            steps {
                sh 'chmod +x app.service'
            }
        }
        stage('Deploy Application'){
            steps{
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'echo Deploying application...'
                    sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ${USERNAME} --key-file ${FILENAME} --inventory hosts.ini playbook.yaml'
                    sh 'echo Deployment complete.'
                }
            }
        }
    }
}
