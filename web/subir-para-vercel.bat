@echo off
setlocal

set "DIR=%~dp0"
cd /d "%DIR%"

echo ============================================
echo   Aurum Web - Publicando no Vercel
echo ============================================
echo Pasta: %DIR%
echo.

where node >nul 2>nul
if errorlevel 1 (
    echo [ERRO] Node.js nao encontrado neste computador.
    echo Instale em https://nodejs.org (versao LTS) e rode este arquivo de novo.
    pause
    exit /b 1
)

echo Na primeira vez, uma janela do navegador vai abrir pedindo
echo para voce fazer login ou criar uma conta gratuita na Vercel.
echo Basta confirmar. Nas perguntas do terminal, pode so apertar
echo ENTER para aceitar as opcoes padrao.
echo.
pause

call npx vercel --prod --yes

if errorlevel 1 (
    echo.
    echo ============================================
    echo [ATENCAO] Algo deu errado no deploy.
    echo Tente rodar "npx vercel login" primeiro e depois
    echo execute este arquivo novamente.
    echo ============================================
    pause
    exit /b 1
)

echo.
echo ============================================
echo   Pronto! Copie o link que comeca com
echo   "Production:" mostrado acima.
echo.
echo   No iPhone: abra esse link no Safari, toque em
echo   Compartilhar e depois em "Adicionar a Tela de
echo   Inicio" para usar como um app.
echo ============================================
pause
