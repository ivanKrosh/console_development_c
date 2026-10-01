@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 8б. Сирі події: ReadConsoleInput.
rem  Порівняти з demo08_line.cmd - ті самі клавіші.
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo8_keys.exe" set "EXE=%~dp0..\x64\Release\Demo8_keys.exe"
if exist "%~dp0..\x64\Debug\Demo8_keys.exe" set "EXE=%~dp0..\x64\Debug\Demo8_keys.exe"
if not defined EXE ( echo [!] Demo8_keys.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo   Натискайте літери, стрілки, Shift. Esc - вихід.
echo.
"%EXE%" events
echo.
echo   Кожна подія окремо; натискання і відпускання - дві події;
echo   у стрілки немає символу (char=0), але є віртуальний код.
pause
