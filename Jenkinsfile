pipeline {
  agent any
  stages {
    stage('artifact and docker') {
      parallel {
        stage('create artifact') {
          steps {
            sh 'echo "artifact"'
            archiveArtifacts 'app/build/libs/'
          }
        }

        stage('dockerize application') {
          steps {
            sh 'echo "dockerize"'
          }
        }

      }
    }

  }
  environment {
    docker_username = 'emilkolvigraun'
  }
}