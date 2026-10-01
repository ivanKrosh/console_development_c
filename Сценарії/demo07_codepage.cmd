@echo off
chcp 65001 > nul
rem ============================================================
rem  Демо 7. Кирилиця чотирма способами.
rem  Сценарій сам вмикає кодову сторінку 866 (типова для української
rem  Windows) - результат не залежить від налаштувань машини.
rem  УВАГА: рядки з chcp 866 мають бути лише латиницею і повертати 65001
rem  у тому самому рядку - cmd читає командний файл у поточній кодовій сторінці.
rem ============================================================
cd /d "%~dp0"
set "EXE="
if exist "%~dp0..\x64\Release\Demo7_cyr.exe" set "EXE=%~dp0..\x64\Release\Demo7_cyr.exe"
if exist "%~dp0..\x64\Debug\Demo7_cyr.exe" set "EXE=%~dp0..\x64\Debug\Demo7_cyr.exe"
if not defined EXE ( echo [!] Demo7_cyr.exe не знайдено. Зберіть рішення: Build - Build Solution. & exit /b 1 )

echo === 7а. Консоль у кодовій сторінці 866 ===
echo.
echo ^> Demo7_cyr.exe raw     (printf як є)
chcp 866 > nul & "%EXE%" raw & chcp 65001 > nul
echo.
echo ^> Demo7_cyr.exe cp      (SetConsoleOutputCP + printf)
chcp 866 > nul & "%EXE%" cp & chcp 65001 > nul
echo.
echo ^> Demo7_cyr.exe wide    (_setmode + wprintf)
chcp 866 > nul & "%EXE%" wide & chcp 65001 > nul
echo.
echo ^> Demo7_cyr.exe api     (WriteConsoleW)
chcp 866 > nul & "%EXE%" api & chcp 65001 > nul
pause

echo.
echo === 7б. Те саме - у файл ===
echo.
for %%m in (raw cp wide api) do (
    "%EXE%" %%m > c_%%m.txt
    for %%s in (c_%%m.txt) do echo   %%m: %%~zs байт у файлі
)
echo.
echo   raw, cp - UTF-8; wide - UTF-16; api - у файлі лише заголовок:
echo   WriteConsoleW працює тільки з консоллю (помилка 6 вище).
del c_*.txt > nul 2>&1
pause
