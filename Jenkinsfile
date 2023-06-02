pipeline{
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                metadata: 
                    labels: 
                        name: test-gradle-pipelines
                spec: 
                    containers: 
                        -   name: gradle-jenkins
                            image: gradle:8.1.1-jdk11-alpine
                            command: 
                                -   cat
                    tty: true 

                    volumeMounts:
                        -   mountPath: /var/lib/docker
                            name: jenkins-images
                        -   mountPath: "/var/run/docker.sock"
                            name: dockersock
                            
                    volumes:
                        -   name: jenkins-images
                            persistentVolumeClaim:
                                claimName: efs-claim-jenkins1
                        -   name: dockersock
                            hostPath:
                                path: /var/run/docker.sock 
            '''
        }
    }
    
    stages {
        stage('Clone Repository'){
            steps {
            container("gradle-jenkins"){
                script {
                    sh'rm -r .git'
                    final scmVars = checkout(scm)
                    env.BRANCH_NAME = scmVars.GIT_BRANCH
                    env.SHORT_COMMIT = "${scmVars.GIT_COMMIT[0..7]}"
                    env.GIT_REPO_NAME = scmVars.GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1')
                }
            }}
        }

        stage('Hello World'){
            steps{
                container("gradle-jenkins"){
                    script{
                        sh 'echo $PATH'
                    }  
                }
            }
        } 
        stage("Compilation") {
            steps{
                container("gradle-jenkins"){
                    script{
                        sh 'gradle assemble'
            }}
        }}

        stage("Runing unit tests") {
            steps{
            container("gradle-jenkins"){
                script{
                    sh 'gradle test'
                }}
        }}
        // // Build Docker Image
        stage('Build Docker Image') {
            steps{
            container("gradle-jenkins"){
                script{
                    sh "docker info"
                    sh 'gradle docker'
                }
            }
        }   
    }
}} 







