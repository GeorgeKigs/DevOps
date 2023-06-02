pipeline{
    agent any
    
    stages {
        stage('Clone Repository'){
            steps {
                script{
                    sh'rm -r .git'
                    final scmVars = checkout(scm)
                    env.BRANCH_NAME = scmVars.GIT_BRANCH
                    env.SHORT_COMMIT = "${scmVars.GIT_COMMIT[0..7]}"
                    env.GIT_REPO_NAME = scmVars.GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1')
                }
            }
        }

        stage('Hello World'){
            steps{
                sh 'echo $PATH'
            }
        } 
        stage("installation of gradle"){
            steps{
                sh 'echo installing gradle and docker...'
                sh'chmod +x script.sh'
                sh'./script.sh'
            }
        }
        stage("Compilation") {
            steps{
            sh 'gradle assemble'
        }}

        stage("Runing unit tests") {
            steps{
            sh 'gradle test'
        }}
        // // Build Docker Image
        stage('Build Docker Image') {
            steps{
                sh "docker info"
                sh 'gradle docker'
        }   
    }
}} 







