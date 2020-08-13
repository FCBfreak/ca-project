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

    stage('zip artifact') {
      options {
        skipDefaultCheckout(true)
      }
      steps {
        unstash 'code'
        // sh 'zip -r artifact.zip app'
        script{
          zip archive: true, dir: 'app', glob: '', zipFile: 'artifact.zip'
        }

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
            zip zipFile: 'test.zip', archive: false, dir: 'app'
            archiveArtifacts artifacts: 'test.zip', fingerprint: true
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