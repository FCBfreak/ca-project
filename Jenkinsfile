pipeline {
  agent any
  stages {
    stage('stashing') {
      // when {
      //   branch 'master'
      // }
      options {
        // syntax for git pull
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
            // syntax for git pull
            skipDefaultCheckout(true)
          }
          steps {
            unstash 'code'
            sh 'ls'
            sh 'echo "artifact"'
            archiveArtifacts(artifacts: 'app/build/libs/', allowEmptyArchive: true)
          }
        }

        stage('dockerize application') {
          options {
            // syntax for git pull
            skipDefaultCheckout(true)
          }
          when {
            branch 'master'
          }
          environment {
            DOCKERCREDS = credentials('docker_login')
          }
          steps {
            unstash 'code'
            sh 'ls'
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