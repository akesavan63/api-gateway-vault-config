@echo off
cd %~dp0
echo Launching vault instance
docker-compose up -d

docker-compose exec vault sh /scripts/init-data.sh
echo Configuring the vault instance
cd %~dp0
echo .
echo .

