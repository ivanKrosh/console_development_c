@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 1, частина 2. Розв'язка гачка.
rem  Текст лежав у буфері CRT у пам'яті процесу.
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo1_lost.exe" set "EXE=%~dp0..\x64\Release\Demo1_lost.exe"
if exist "%~dp0..\x64\Debug\Demo1_lost.exe" set "EXE=%~dp0..\x64\Debug\Demo1_lost.exe"
if not defined EXE ( echo [!] Demo1_lost.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo === 1а. Як завершилась програма ===
echo.
echo ^> Demo1_lost.exe crash
"%EXE%" crash > nul
echo   ERRORLEVEL = %ERRORLEVEL%   (це 0xC0000005 - порушення доступу)
echo.
echo   Програма звернулась за нульовою адресою і була знищена системою.
pause

echo.
echo === 1б. Чотири способи завершення - вивід у файл ===
echo.
"%EXE%" > out.txt
for %%s in (out.txt) do echo   return 0 з main      %%~zs байт
"%EXE%" exit > out.txt
for %%s in (out.txt) do echo   exit(3)              %%~zs байт
"%EXE%" crash > out.txt
for %%s in (out.txt) do echo   аварія               %%~zs байт
"%EXE%" kill > out.txt
for %%s in (out.txt) do echo   TerminateProcess     %%~zs байт
echo.
echo   return і exit скидають буфери CRT. Аварія і TerminateProcess - ні:
echo   буфер загинув разом із процесом.
pause

echo.
echo === 1в. Виправлення: fflush перед небезпечним місцем ===
echo.
echo ^> Demo1_lost.exe crash flush ^> out.txt
"%EXE%" crash flush > out.txt
type out.txt
echo.
for %%s in (out.txt) do echo   [розмір out.txt: %%~zs байт]
echo.
echo   fflush(stdout) віддав буфер системі до аварії.
del out.txt > nul 2>&1
pause
