@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 4. Що насправді робить scanf.
rem  До запуску спрогнозуйте: скільки разів програма чекатиме введення?
rem  Ctrl+Z тут не пробуйте: зі scanf у консолі MSVC він спрацьовує
rem  лише з третього разу. Кінець введення - у demo05_reliable.cmd.
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo4_scanf.exe" set "EXE=%~dp0..\x64\Release\Demo4_scanf.exe"
if exist "%~dp0..\x64\Debug\Demo4_scanf.exe" set "EXE=%~dp0..\x64\Debug\Demo4_scanf.exe"
if not defined EXE ( echo [!] Demo4_scanf.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo === 4а. Введіть 42 і Enter ===
echo.
"%EXE%"
echo.
echo   Другий scanf не чекав: він забрав \n (код 10), що лишився після 42.
pause

echo.
echo === 4б. Введіть abc і Enter ===
echo.
"%EXE%"
echo.
echo   scanf("%%d") повернув 0 і нічого не забрав. abc лишився в буфері
echo   і дістався наступному scanf("%%c").
echo   Висновок: значення, яке повертає scanf, треба перевіряти завжди.
pause
