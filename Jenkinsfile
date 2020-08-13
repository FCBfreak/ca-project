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

    // stage('testing') {
    //   parallel {
    //     stage('docker-compose test') {
    //       options {
    //         skipDefaultCheckout(true)
    //       }
    //       steps {
    //         unstash 'code'
    //         sh './component-test.sh'
    //       }
    //     }
    //     stage('unit test') {
    //       options {
    //         skipDefaultCheckout(true)
    //       }
    //       steps {
    //         unstash 'code'
    //         sh './unit-test.sh'
    //       }
    //     }
    //   }
    // }

    stage('artifact and docker') {
      parallel {
        stage('create artifact') {
          options {
            skipDefaultCheckout(true)
          }
          steps {
            unstash 'code'
            script {
              zip archive: true, dir: 'src', zipFile: 'archive.zip'
            }
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