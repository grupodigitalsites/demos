@echo off
title Publicar Demos - GitHub Pages (grupodigitalsites/demos)
cd /d "%~dp0"
echo.
echo ============================================================
echo    PUBLICANDO AS DEMOS NO GITHUB PAGES
echo    Repositorio: grupodigitalsites/demos
echo ============================================================
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo  [ERRO] Git nao encontrado neste computador.
  echo  Instale em: https://git-scm.com/download/win
  echo  Depois clique neste arquivo de novo.
  goto fim
)

git config user.email >nul 2>nul || git config user.email "grupodigital163@gmail.com"
git config user.name  >nul 2>nul || git config user.name  "Juliano Travain"

if not exist ".git" (
  echo  - Inicializando repositorio local...
  git init
)
git branch -M main >nul 2>nul
git remote remove origin >nul 2>nul
git remote add origin https://github.com/grupodigitalsites/demos.git

echo  - Preparando arquivos...
git add -A
git commit -m "Atualizacao demos nutricionistas Sinop (Premium e Ultra)" >nul 2>nul

echo  - Enviando para o GitHub...
echo    (se abrir tela de login, entre com a conta grupodigitalsites)
echo.
git push -u origin main --force
set RESULT=%errorlevel%
echo.

if "%RESULT%"=="0" (
  echo ============================================================
  echo    [OK] PUBLICADO COM SUCESSO!
  echo.
  echo    As paginas ficam no ar em ~1 minuto:
  echo    https://grupodigitalsites.github.io/demos/
  echo.
  echo    Agora escreva  "subi"  para o Claude verificar os links.
  echo ============================================================
  echo.
  echo  Abrindo a lista de demos no navegador...
  start "" "https://grupodigitalsites.github.io/demos/"
) else (
  echo ============================================================
  echo    [FALHOU] O envio nao foi concluido. Codigo: %RESULT%
  echo.
  echo    Verifique:
  echo     1) No login, use a conta  grupodigitalsites
  echo     2) Se pedir senha no terminal, use um TOKEN do GitHub
  echo     3) Sua conexao com a internet
  echo ============================================================
)

:fim
echo.
echo  --------------------------------------------------------
echo   Esta janela NAO vai fechar sozinha.
echo   Leia a mensagem acima e aperte uma tecla para sair.
echo  --------------------------------------------------------
pause >nul
