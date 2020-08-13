#!/bin/bash

docker push "$docker_username/ca-project:1.0-${GIT_COMMIT::4}" 
docker push "$docker_username/ca-project:latest" &
wait