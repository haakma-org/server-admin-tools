pipeline {
  agent any
  stages {
    stage('Preparation') {
      steps {
        // Clean workspace
        step([$class: 'WsCleanup', cleanWhenFailure: false])
        // Get code from github.com
        checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: 'master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'jenkins-git', url: 'http://jenkins@github.com/sidohaakma/server-administration-tools.git']]]
      }
    }
    stage('Build RPM') {
      steps {
        mvn
      }
    }
  }
  post {
    success {
      notifySuccess()
    }
    failure {
      notifyFailed()
    }
  }
}

def notifySuccess() {
  slackSend (channel: '#haakma-org', color: '#00FF00', message: "SUCCESSFUL: Job - <${env.BUILD_URL}|${env.JOB_NAME}> | #${env.BUILD_NUMBER}")
}
def notifyFailed() {
  slackSend (channel: '#haakma-org', color: '#FF0000', message: "FAILED: Job - <${env.BUILD_URL}|${env.JOB_NAME}> | #${env.BUILD_NUMBER}")
}
