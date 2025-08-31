@echo off
echo [Deploy] Kopiere Hook-Skripte in DCS Server...

REM Quelle = hooks Ordner im Repo
set SRC=%~dp0hooks

REM Ziel = DCS Hooks-Ordner
set DEST=%USERPROFILE%\Saved Games\DCS.openbeta_server\Scripts\Hooks

xcopy "%SRC%\*.lua" "%DEST%\" /Y /I

echo [Deploy] Fertig! Hooks wurden nach %DEST% kopiert.
pause
