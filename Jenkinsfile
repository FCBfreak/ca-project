pipeline {
  agent any
  stages {
    stage('stashing') {
      when {
        branch 'master'
      }
      options {
        skipDefaultCheckout(true)
      }
      steps {
        stash(excludes: '.git', name: 'code')
      }
    }

    stage('artifact and docker') {
      parallel {
        stage('create artifact') {
          steps {
            sh 'echo "artifact"'
            archiveArtifacts(artifacts: 'app/build/libs/', allowEmptyArchive: true)
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
            sh 'build-docker.sh'
            sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin'
            sh 'push-docker.sh'
          }
        }

      }
    }

  }
  environment {
    docker_username = 'emilkolvigraun'
  }
}