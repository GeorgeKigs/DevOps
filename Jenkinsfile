node {
    stage("Clone the project") {
        git branch: 'development',
        credentialsId: 'new-gitlab-token',
        url: 'https://gitlab.com/trial-group353121/gradle-jenkins.git'
    }
    stage("check path"){
        sh 'echo $PATH'
    }
    stage('Build') {
        sh 'gradle assemble'
    }
    stage('Test') {
        sh 'gradle test'
    }
    stage('Build Docker Image') {
        sh 'gradle docker'
    }

}