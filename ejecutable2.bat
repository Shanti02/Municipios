@echo off
title Proyecto Municipios

echo INICIANDO DOCKER
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

:waitloop
docker info >nul 2>&1
if errorlevel 1 (
    timeout /t 5 >nul
    goto waitloop
)

echo ELIMINANDO CONTENEDOR SI EXISTE

docker rm -f municipios >nul 2>&1

echo CREANDO CONTENEDOR

docker run -d --name municipios ^
-e MARIADB_ROOT_PASSWORD=1234 ^
-e MARIADB_DATABASE=municipios ^
-p 3309:3306 ^
-v "%cd%:/datos" ^
-e MARIADB_MYSQLD_OPTS="--secure-file-priv=" ^
mariadb:latest

echo Esperando que MariaDB inicie...
timeout /t 25 >nul


echo VALIDAR ARCHIVOS
docker exec municipios ls -la /datos


echo EJECUTAR SCRIPTS SQL
docker exec -i municipios mariadb -u root -p1234 municipios < ScriptDatabase.sql
docker exec -i municipios mariadb -u root -p1234 municipios < ScriptCargar.sql
docker exec -i municipios mariadb -u root -p1234 municipios < Consulta.sql


echo CREANDO ESTRUCTURA PYTHON
mkdir PPythonPrueba 2>nul
cd PPythonPrueba

mkdir notebooks 2>nul
type nul > ppythonPrueba.ipynb

mkdir src 2>nul
mkdir src\controller 2>nul
mkdir src\model 2>nul
mkdir src\view 2>nul
mkdir src\persistence 2>nul
mkdir src\datasets 2>nul

type nul > main.py

echo ABRIENDO VISUAL STUDIO CODE

start "" "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\Code.exe" "%cd%"

echo CREANDO ENTORNO VIRTUAL

python -m venv .venv

call .venv\Scripts\activate.bat

python -m pip install --upgrade pip
pip install jupyter
pip install ipykernel
pip install pandas

python -m ipykernel install --user --name=.venv --display-name "Python(.venv)"

echo PROCESO FINALIZADO

pause