@echo off
REM =============================================================
REM  C++17 By Example - Chinese edition  (one-click build, Windows)
REM  Requires: TeX Live 2026 + Python 3.  Double-click to build.
REM  ASCII-only on purpose (see template notes on .bat encoding).
REM =============================================================
setlocal EnableExtensions

set TEXBIN=D:\ProgramData\texlive\2026\bin\windows
set PYTHON=D:\anaconda3

set "PATH=%PYTHON%;%TEXBIN%;%PATH%"
set "PYTHONPATH="

REM [CRITICAL] minted v3 cache dir must be an absolute path = project root.
for %%A in ("%~dp0.") do set "TEXMF_OUTPUT_DIRECTORY=%%~fA"
set "TEXMFOUTPUT=%TEXMF_OUTPUT_DIRECTORY%"
echo [build] project root = %TEXMF_OUTPUT_DIRECTORY%

cd /d "%~dp0."

xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
if errorlevel 1 goto :err
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
if errorlevel 1 goto :err
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
if errorlevel 1 goto :err

findstr /C:"Cannot write file" /C:"Cannot highlight code" main.log >nul 2>&1
if not errorlevel 1 (
  echo.
  echo [WARN] minted highlight failures still present in main.log. Check:
  echo        - is python.exe on PATH?
  echo        - does book/ccs.tex resolve \minted@cachedir to an absolute path?
  goto :err
)

echo.
echo [cleanup] removing *.minted / *.listing from the current directory...
for %%F in ("%CD%\*.minted") do @del /q "%%~fF" 2>nul
for %%F in ("%CD%\*.listing") do @del /q "%%~fF" 2>nul

set "LEFT=0"
for %%F in ("%CD%\*.minted") do set /a LEFT+=1
if "%LEFT%"=="0" (
  echo [cleanup] done - no *.minted files left.
) else (
  echo [cleanup] WARN: %LEFT% *.minted still locked.
)

echo.
echo Build finished. Output: main.pdf
goto :eof

:err
echo.
echo Build FAILED. See main.log in this directory.
pause
