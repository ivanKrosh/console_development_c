@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 9. Колір: WinAPI проти VT-послідовностей.
rem  Файл не дивіться через type: консоль знову виконає VT-коди.
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo9_color.exe" set "EXE=%~dp0..\x64\Release\Demo9_color.exe"
if exist "%~dp0..\x64\Debug\Demo9_color.exe" set "EXE=%~dp0..\x64\Debug\Demo9_color.exe"
if not defined EXE ( echo [!] Demo9_color.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo ^> Demo9_color.exe
"%EXE%"
echo.
pause

echo ^> Demo9_color.exe ^> col.txt
"%EXE%" > col.txt
echo   Вміст col.txt (байт ESC показано як ^<ESC^>):
echo.
powershell -NoProfile -Command "Get-Content col.txt | ForEach-Object { $_ -replace [char]27, '<ESC>' }"
echo.
echo   SetConsoleTextAttribute з файлом не спрацював - лишився чистий текст.
echo   VT-коди - звичайні байти в потоці, тому потрапили у файл.
echo.
echo   Відкрити col.txt у Блокноті? [Y/N]
choice /c YN /n > nul
if errorlevel 2 goto skip
start /wait notepad col.txt
:skip
del col.txt > nul 2>&1
