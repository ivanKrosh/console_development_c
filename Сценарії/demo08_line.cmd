@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 8а. getchar: рядок збирає і редагує консоль.
rem  До запуску спрогнозуйте: коли getchar отримає першу літеру?
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo8_keys.exe" set "EXE=%~dp0..\x64\Release\Demo8_keys.exe"
if exist "%~dp0..\x64\Debug\Demo8_keys.exe" set "EXE=%~dp0..\x64\Debug\Demo8_keys.exe"
if not defined EXE ( echo [!] Demo8_keys.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo   Наберіть: a, b, стрілка вліво, X, Enter
echo.
"%EXE%" line
echo.
echo   Програма отримала aXb і до Enter - нічого. Стрілок вона не бачила:
echo   їх обробила консоль у рядковому режимі.
pause
