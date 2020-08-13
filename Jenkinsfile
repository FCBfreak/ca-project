pipeline {
  environment {
    docker_username = 'emilkolvigraun'
  }
  agent any
  stages {
    stage('stashing'){
      when {
        branch 'master'
      }
      steps {
        stash 'code'
      }
    }
    stage('artifact and docker') {

      parallel {
        stage('create artifact') {
          steps {
            sh 'echo "artifact"'
            archiveArtifacts 'app/build/libs/'
          }
        }

        stage('dockerize application') {
          environment {
            DOCKERCREDS = credentials('docker_login')
          }
          when {
            branch 'master'
          }
          steps {
            unstash 'code'
            sh 'ci/build-docker.sh'
            sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin' //login to docker hub with the credentials above
            sh 'ci/push-docker.sh'
            sh 'echo "pushed to docker!"'
          }
        }
      }
    }
  }
}