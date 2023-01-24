pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo "building image"
                sh 'ansible-playbook base_run.yml -i inventories/local/hosts.yml --diff --tags "clean,build"'
            }
        }

        stage('Deploy') {
            steps {
                echo "deploying"
                sh 'ansible-playbook base_run.yml -i inventories/local/hosts.yml --diff --tags "deploy"'
            }
        }

        stage('Test') {
            steps {
                echo "running test"
                sh 'ansible-playbook base_run.yml -i inventories/local/hosts.yml --diff --tags "test"'
            }
        }

        stage('Push to repo') {
            steps {
                echo "push image to repo"
                sh 'ansible-playbook base_run.yml -i inventories/local/hosts.yml --diff --tags "push"'
            }
        }

        stage('Deploy Dev') {
            when {
                branch 'develop'
            }
            steps {
                echo "deploying to Dev "
                sh 'ansible-playbook base_run.yml -u root -i inventories/dev/hosts.yml --diff --tags "deploy,test"'
            }
        }

        stage('Deploy Prod') {
            when {
                branch 'master'
            }
            steps {
                echo "deploying to Production "
                sh 'ansible-playbook base_run.yml -u root -i inventories/prod/hosts.yml --diff --tags "deploy,test"'
            }
        }
    }
}