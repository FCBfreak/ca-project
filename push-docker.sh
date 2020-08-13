#!/bin/bash

docker push "$docker_username/ci-project:1.0-${GIT_COMMIT::4}" 
docker push "$docker_username/ci-project:latest" &
wait