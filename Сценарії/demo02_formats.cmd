@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 2. Сімейство printf.
rem  До запуску подивіться код і спрогнозуйте:
rem  яка ширина колонок, як виглядатиме %#8x і 145.875 з %.2f?
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo2_printf.exe" set "EXE=%~dp0..\x64\Release\Demo2_printf.exe"
if exist "%~dp0..\x64\Debug\Demo2_printf.exe" set "EXE=%~dp0..\x64\Debug\Demo2_printf.exe"
if not defined EXE ( echo [!] Demo2_printf.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo ^> Demo2_printf.exe
echo.
"%EXE%"
echo.
echo   printf повертає кількість БАЙТІВ: "абв\n" - це 3 x 2 + 1 = 7.
echo   Тому й ширина %%-8s рахує байти: рядок з кирилицею коротший на екрані.
pause
