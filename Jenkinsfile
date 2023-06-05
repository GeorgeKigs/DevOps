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
        stage("Compilation") {
            steps{
            sh """
                if ! [ -d /opt/gradle/gradle-8.1.1/bin/ ]; then
                wget https://services.gradle.org/distributions/gradle-8.1.1-bin.zip -P /tmp
                sudo unzip -d /opt/gradle /tmp/gradle-8.1.1-bin.zip
                fi
                export PATH=$PATH:/opt/gradle/gradle-8.1.1/bin
                gradle assemble
            """
        }}

        stage("Runing unit tests") {
            steps{
                sh """
                    if ! [ -d /opt/gradle/gradle-8.1.1/bin/ ]; then
                    wget https://services.gradle.org/distributions/gradle-8.1.1-bin.zip -P /tmp
                    sudo unzip -d /opt/gradle /tmp/gradle-8.1.1-bin.zip
                    fi
                    export PATH=$PATH:/opt/gradle/gradle-8.1.1/bin
                    gradle test
                """
        }}
        // // Build Docker Image
        stage('Build Docker Image') {
            steps{
                sh "docker info"
                sh """
                    export PATH=$PATH:/opt/gradle/gradle-8.1.1/bin 
                    gradle docker
                    gradle dockerTagAws-image
                """
            }   
        }
        stage('Login to ECR'){
          steps{
            script{
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AKIA3FUCNL2SIAEDK2TC', credentialsId: '6c90b173-f192-4a8e-a50d-cd4b66b11db2', secretKeyVariable: '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']]) {
              sh 'aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 767998910116.dkr.ecr.eu-west-1.amazonaws.com'
            }
          }
        }
        }


        stage('Push Image to UAT AWS Registry') {
            steps {
                script {
                    retry(3) {
                        // sh 'docker tag test-jenkins-pipeline:latest 767998910116.dkr.ecr.eu-west-1.amazonaws.com/test-jenkins-pipeline:latest'
                        sh "docker push 767998910116.dkr.ecr.eu-west-1.amazonaws.com/test-jenkins-pipeline:latest"
                    }
                }
            }
        }
}} 







