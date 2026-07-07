@echo off
setlocal

set "REPO_DIR=%~dp0"
set "REMOTE_URL=https://github.com/zBelga/finance.git"

cd /d "%REPO_DIR%"

echo ============================================
echo   Aurum - Enviando projeto para o GitHub
echo ============================================
echo Pasta: %REPO_DIR%
echo Repositorio: %REMOTE_URL%
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo [ERRO] Git nao foi encontrado neste computador.
    echo Instale em https://git-scm.com/download/win e rode este arquivo de novo.
    pause
    exit /b 1
)

if not exist ".git" (
    echo Inicializando repositorio git local...
    git init
    git branch -M main
)

git remote get-url origin >nul 2>nul
if errorlevel 1 (
    echo Configurando remote "origin"...
    git remote add origin "%REMOTE_URL%"
) else (
    echo Remote "origin" ja configurado.
)

echo.
echo Adicionando arquivos...
git add -A

echo Criando commit...
git commit -m "Aurum: atualizacao do projeto"
if errorlevel 1 (
    echo (Nada novo para commitar - seguindo para o envio)
)

echo.
echo Enviando para o GitHub...
echo Se for a primeira vez, uma janela de login do GitHub pode abrir - faca o login normalmente.
git push -u origin main

if errorlevel 1 (
    echo.
    echo ============================================
    echo [ATENCAO] O envio falhou. Causas mais comuns:
    echo  1. Voce ainda nao autenticou com o GitHub neste PC.
    echo  2. O repositorio remoto ja tem commits diferentes dos seus.
    echo     Nesse caso, abra o Prompt de Comando nesta pasta e rode:
    echo       git pull origin main --allow-unrelated-histories
    echo     Depois rode este arquivo novamente.
    echo ============================================
    pause
    exit /b 1
)

echo.
echo ============================================
echo   Concluido! Confira em:
echo   https://github.com/zBelga/finance
echo ============================================
pause
