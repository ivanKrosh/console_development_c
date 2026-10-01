@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 5. Надійне введення: fgets + strtol.
rem  Чотири запуски: 42, abc, 42abc, Ctrl+Z і Enter.
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo5_fgets.exe" set "EXE=%~dp0..\x64\Release\Demo5_fgets.exe"
if exist "%~dp0..\x64\Debug\Demo5_fgets.exe" set "EXE=%~dp0..\x64\Debug\Demo5_fgets.exe"
if not defined EXE ( echo [!] Demo5_fgets.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo === Введіть 42 ===
"%EXE%"
echo.
echo === Введіть abc ===
"%EXE%"
echo.
echo === Введіть 42abc ===
"%EXE%"
echo.
echo === Натисніть Ctrl+Z, потім Enter ===
"%EXE%"
echo   ERRORLEVEL = %ERRORLEVEL%
echo.
echo   42abc - головний випадок: scanf("%%d") прийняв би 42 мовчки.
echo   fgets забирає весь рядок - у буфері нічого не лишається.
pause
