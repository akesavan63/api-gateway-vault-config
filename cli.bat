@echo on
cd %~dp0
docker-compose exec vault sh
cd %~dp0

