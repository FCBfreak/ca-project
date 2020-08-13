pipeline {
  agent any
  stages {
    stage('stash always') {
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
          options {
            skipDefaultCheckout(true)
          }
          steps {
            unstash 'code'
            zip archive: true, dir: 'app', glob: '', zipFile: 'artifact.zip'
            archiveArtifacts artifacts: 'artifact.zip', fingerprint: true
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
            sh './build-docker.sh'
            sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin'
            sh './push-docker.sh'
          }
        }

      }
    }

  }
  environment {
    docker_username = 'emilkolvigraun'
  }
}