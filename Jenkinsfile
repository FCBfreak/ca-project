
pipeline {
  environment {
    docker_username = 'emilkolvigraun'
  }
  agent any
  stages {
    stage('first stage'){
      options {
        skipDefaultCheckout(true)
      }
      steps (
        sh 'echo "hello"'
      )
    }
  }
}