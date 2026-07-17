@echo off
setlocal enabledelayedexpansion

:: Check for administrator permissions
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Dieses Skript muss als Administrator ausgefuehrt werden!
    echo Bitte klicken Sie mit der rechten Maustaste auf die Datei und waehlen Sie "Als Administrator ausfuehren".
    pause
    exit /b
)

:: Wechselt in das Verzeichnis der Batch-Datei (wichtig bei "Als Admin ausführen")
cd /d "%~dp0"

set "EXE_PATH=x64\Release\Malwarebytes Unlimited Trial.exe"

if exist "%EXE_PATH%" (
    echo [+] Das Programm wurde bereits kompiliert. Starte Anwendung...
    goto run_app
)

echo [*] Suche nach MSBuild.exe in Standardpfaden...
set "MSBUILD_PATH="

:: Check standard installation paths for MSBuild
for %%p in (
    "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
) do (
    if exist "%%~p" (
        set "MSBUILD_PATH=%%~p"
        goto found_msbuild
    )
)

:found_msbuild
if "%MSBUILD_PATH%"=="" (
    echo [!] MSBuild.exe wurde nicht in den Standardpfaden gefunden.
    echo Bitte vergewissern Sie sich, dass Visual Studio oder die Build Tools installiert sind.
    pause
    exit /b
)

echo [+] MSBuild gefunden unter: "%MSBUILD_PATH%"
echo [*] Kompiliere C++ Projekt...

:: Try default compilation first
"%MSBUILD_PATH%" "Malwarebytes Unlimited Trial.vcxproj" /p:Configuration=Release /p:Platform=x64
if %errorlevel% equ 0 goto build_success

echo [!] Standard-Kompilierung fehlgeschlagen. Versuche mit PlatformToolset v145...
"%MSBUILD_PATH%" "Malwarebytes Unlimited Trial.vcxproj" /p:Configuration=Release /p:Platform=x64 /p:PlatformToolset=v145
if %errorlevel% equ 0 goto build_success

echo [!] Kompilierung fehlgeschlagen. Bitte ueberpruefen Sie die Fehlermeldungen oben.
pause
exit /b

:build_success
echo [+] Kompilierung erfolgreich abgeschlossen!

:run_app
echo [*] Starte: "%EXE_PATH%"
"%EXE_PATH%"
pause
