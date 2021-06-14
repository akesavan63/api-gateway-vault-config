@echo off
cd %~dp0
echo Remove previous instance of vault
docker-compose stop
docker-compose rm -f
echo .
cd %~dp0




