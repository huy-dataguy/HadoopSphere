@echo off
setlocal enabledelayedexpansion

REM The default node number is 3
set N=3
if not "%1"=="" set N=%1

REM Calculate N-1 and store in Nminus1
set /A Nminus1=N-1

echo Resizing cluster to %Nminus1% slave nodes...
call windows/resize-number-slaves.bat %Nminus1%
if errorlevel 1 (
    echo Failed to resize slaves. Exiting...
    exit /b 1
)


docker build -t hdsphere-master-official:latest ./config-hadoop

echo Starting Docker Compose services...
docker compose -f compose-dynamic.yaml up -d
if errorlevel 1 (
    echo Failed to start Docker Compose services. Exiting...
    exit /b 1
)

echo Restarting the cluster...
docker exec -it hdsphere-master /bin/bash -c "su - hadoopquochuy026"
if errorlevel 1 (
    echo Failed to restart the cluster. Exiting...
    exit /b 1
)

echo Cluster setup completed successfully!