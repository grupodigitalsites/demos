@echo off
chcp 65001 >nul
title Publicar Demos - GitHub Pages (grupodigitalsites/demos)
cd /d "%~dp0"
echo.
echo  ============================================================
echo   PUBLICANDO AS DEMOS NO GITHUB PAGES
echo   Repositorio: grupodigitalsites/demos
echo  ============================================================
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo  [ERRO] Git nao encontrado neste computador.
  echo  Instale em: https://git-scm.com/download/win
  echo  Depois clique neste arquivo de novo.
  echo.
  pause
  exit /b 1
)

rem  Garante identidade do git (caso nunca tenha configurado)
git config user.email >nul 2>nul || git config user.email "grupodigital163@gmail.com"
git config user.name  >nul 2>nul || git config user.name  "Juliano Travain"

rem  Inicializa o repositorio local se ainda nao existir
if not exist ".git" (
  echo  - Inicializando repositorio local...
  git init >nul
)
git branch -M main >nul 2>nul

rem  Aponta o remoto para o repo demos
git remote remove origin >nul 2>nul
git remote add origin https://github.com/grupodigitalsites/demos.git

echo  - Preparando arquivos...
git add -A
git commit -m "Atualizacao demos nutricionistas Sinop (Premium e Ultra)" >nul 2>nul
if errorlevel 1 echo    (nada novo para salvar - seguindo para o envio)

echo  - Enviando para o GitHub (pode abrir uma tela de login)...
echo    IMPORTANTE: faca login com a conta  grupodigitalsites
echo.
git push -u origin main --force

if errorlevel 1 (
  echo.
  echo  ============================================================
  echo   [FALHOU] O envio nao foi concluido. Verifique:
  echo    1) No login que abriu, use a conta  grupodigitalsites
  echo    2) Sua conexao com a internet
  echo    3) Se pedir usuario/senha, use um token do GitHub como senha
  echo  ============================================================
  echo.
  pause
  exit /b 1
)

echo.
echo  ============================================================
echo   [OK] PUBLICADO COM SUCESSO!
echo   Em ~1 minuto as paginas estarao no ar:
echo.
echo   Lista geral:
echo     https://grupodigitalsites.github.io/demos/
echo.
echo   Agora avise o Claude escrevendo:  subi
echo   que ele confere os links e grava no dashboard.
echo  ============================================================
echo.
pause
