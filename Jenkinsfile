node {
    
    stages {
        
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