pipeline {
  agent any
  stages {
    stage('stashing') {
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
            archiveArtifacts 'app/build/libs/**'
          }
        }

        stage('dockerize application') {
          when {
            branch 'master'
          }
          environment {
            DOCKERCREDS = credentials('docker_login')
          }
          steps {
            unstash 'code'
            sh 'ci/build-docker.sh'
            sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin'
            sh 'ci/push-docker.sh'
            sh 'echo "pushed to docker!"'
          }
        }

      }
    }

  }
  environment {
    docker_username = 'emilkolvigraun'
  }
}