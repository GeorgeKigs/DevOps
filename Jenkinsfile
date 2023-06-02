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
                        -   name: maven
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
                script {
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
        stage("Compilation") {
            steps{
                sh 'gradle assemble'
            }
        }

        stage("Runing unit tests") {
                steps{
                    sh 'gradle test'
                }
        }
        // // Build Docker Image
        stage('Build Docker Image') {
            steps {
                steps {
                    sh "docker info"
                    sh 'gradle docker'
                }
            }
        }   
    }
} 







