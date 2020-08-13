
pipeline {
  environment {
    docker_username = 'emilkolvigraun'
  }
  agent any
  stages {
    stage('artifact and docker'){
      parallel {
        stage('create artifact'){
          steps {
            sh 'echo "artifact"'
          }
        }
        stage('dockerize application'){
          steps {
            sh 'echo "dockerize"'
          }
        }
      }
    }
  }
}