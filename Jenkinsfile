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
        // stage('Deploy Application'){
        //     steps{
        //         withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
        //             sh 'echo Deploying application...'
        //             sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ${USERNAME} --key-file ${FILENAME} --inventory hosts.ini playbook.yaml'
        //             sh 'echo Deployment complete.'
        //         }
        //     }
        // }
        stage ('Build and Push Docker Image') {
            steps {
                sh "docker build . --tag ttl.sh/my-app:v1"
                sh "docker push ttl.sh/my-app:v1"
            }
        }
        stage("Docker Run Image"){
            steps {
                 withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker "docker stop my-app || true"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker "docker rm my-app || true"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker "docker run -d -p 3000:3000 ttl.sh/my-app:v1"'
                }
            }
        }
    }
}
