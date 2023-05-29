node {
    
    stages {
        stage("Clone the project") {
            steps{
                git branch: 'development', url: 'https://gitlab.com/trial-group353121/gradle-jenkins.git'
            }
        }
        stage('Build') {
            steps {
                sh 'gradle assemble -g ~/.gradle'
            }
        }
         stage('Test') {
            steps {
                sh 'gradle test -g ~/.gradle'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'gradle docker -g ~/.gradle'
            }
        }
        stage('Run Docker Image') {
            steps {
                sh 'gradle dockerRun -g ~/.gradle'
            }
        }
    }
}