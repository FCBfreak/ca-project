pipeline {
  agent any
  stages {
    environment {
    docker_username = 'emilkolvigraun'
    }
    stage('stashing') {
      options {
          skipDefaultCheckout(true)
      }
      when {
        branch 'master'
      }
      steps {
        stash (
          excludes: '.git',
          name: 'code'
        )
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
          environment {
            DOCKERCREDS = credentials('docker_login')
          }
          when {
            branch 'master'
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
  
}