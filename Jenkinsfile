pipeline {
  agent any
  stages {
    stage('stash always') {
      options {
        // syntax for git pull
        skipDefaultCheckout(true)
      }
      steps {
        stash(excludes: '.git', name: 'code')
      }
    }

    stage('zip artifact') {
      options {
        // syntax for git pull
        skipDefaultCheckout(true)
      }
      steps {
        unstash 'code'
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
            archiveArtifacts(artifacts: 'artifact.zip', allowEmptyArchive: true)
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