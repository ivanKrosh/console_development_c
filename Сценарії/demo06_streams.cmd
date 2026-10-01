@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 6. Два потоки - два буфери.
rem  До другого запуску спрогнозуйте: у якому порядку рядки будуть у файлі?
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo6_order.exe" set "EXE=%~dp0..\x64\Release\Demo6_order.exe"
if exist "%~dp0..\x64\Debug\Demo6_order.exe" set "EXE=%~dp0..\x64\Debug\Demo6_order.exe"
if not defined EXE ( echo [!] Demo6_order.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo ^> Demo6_order.exe
"%EXE%"
echo.
pause

echo ^> Demo6_order.exe ^> all.txt 2^>^&1
"%EXE%" > all.txt 2>&1
echo ^> type all.txt
type all.txt
echo.
echo   stderr без буфера - потрапив у файл одразу.
echo   stdout чекав у буфері CRT до завершення програми.
del all.txt > nul 2>&1
pause
