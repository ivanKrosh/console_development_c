@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 1, частина 1. Гачок: куди зник текст.
rem  Путівник, станція 1. Спершу подумайте, що буде у файлі.
rem  Пояснення - у demo01_answer.cmd (станція 7).
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo1_lost.exe" set "EXE=%~dp0..\x64\Release\Demo1_lost.exe"
if exist "%~dp0..\x64\Debug\Demo1_lost.exe" set "EXE=%~dp0..\x64\Debug\Demo1_lost.exe"
if not defined EXE ( echo [!] Demo1_lost.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo ^> Demo1_lost.exe crash
"%EXE%" crash
echo.
echo.
pause

echo ^> Demo1_lost.exe crash ^> out.txt
"%EXE%" crash > out.txt
echo ^> type out.txt
type out.txt
echo.
for %%s in (out.txt) do echo   [розмір out.txt: %%~zs байт]
echo.
echo   Та сама програма. Той самий текст. Куди він подівся?
del out.txt > nul 2>&1
pause
