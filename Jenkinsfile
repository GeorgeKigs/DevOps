pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage("Clone the project") {
            git branch: 'development', url: 'https://gitlab.com/trial-group353121/gradle-jenkins.git'
        }
        stage('Build') {
            steps {
                sh 'gradle assemble'
            }
        }
         stage('Test') {
            steps {
                sh 'gradle test'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'gradle docker'
            }
        }
        stage('Run Docker Image') {
            steps {
                sh 'gradle dockerRun'
            }
        }
    }
}