@echo off
set version=%1

IF [%1] == [] GOTO MISSINGPARAMETER

:BUILD

docker build --rm -f "Dockerfile" -t emilkolvigraun/ca-project:%version% .
docker tag emilkolvigraun/ca-project:%version% emilkolvigraun/ca-project:latest

GOTO EXIT

:MISSINGPARAMETER
echo Please add the version number like "build.cmd 1.0"
GOTO EXIT

:EXIT
