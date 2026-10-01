@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 3. Текстовий режим: \n стає \r\n.
rem  До запуску спрогнозуйте: скільки байт буде в кожному файлі?
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo3_textmode.exe" set "EXE=%~dp0..\x64\Release\Demo3_textmode.exe"
if exist "%~dp0..\x64\Debug\Demo3_textmode.exe" set "EXE=%~dp0..\x64\Debug\Demo3_textmode.exe"
if not defined EXE ( echo [!] Demo3_textmode.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo   Рядок "ab\ncd\nef\n" (9 символів) записано двічі:
echo   через fopen("w") і через fopen("wb").
echo.
"%EXE%"
echo.
echo   У текстовому режимі CRT дописала 0D перед кожним 0A.
echo   Ваш код цього не робив - це зробила бібліотека.
del text.txt bin.txt > nul 2>&1
pause
