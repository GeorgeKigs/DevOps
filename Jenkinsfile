node {
    stage("Clone the project") {
        git branch: 'development', url: 'https://gitlab.com/trial-group353121/gradle-jenkins.git'
    }
    stage("check path"){
        sh 'echo $PATH'
    }
    stage('Build') {
        sh 'gradle assemble -g ~/.gradle'
    }
    stage('Test') {
        sh 'gradle test -g ~/.gradle'
    }
    stage('Build Docker Image') {
        sh 'gradle docker -g ~/.gradle'
    }
    stage('Run Docker Image') {
        sh 'gradle dockerRun -g ~/.gradle'
    }
    
}