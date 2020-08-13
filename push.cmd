@echo off
set version=%1

IF [%1] == [] GOTO MISSINGPARAMETER

:PUBLISH

docker tag emilkolvigraun/ca-project:%version% emilkolvigraun/ca-project:latest
docker push emilkolvigraun/ca-project:%version%
docker push emilkolvigraun/ca-project:latest 

GOTO EXIT

:MISSINGPARAMETER
echo Please add the version number like "push.cmd 1.0"
GOTO EXIT

:EXIT
