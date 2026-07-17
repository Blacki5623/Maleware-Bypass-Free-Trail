@echo off
setlocal enabledelayedexpansion

:: Check for administrator permissions
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] This script must be run as Administrator!
    echo Please right-click the file and select "Run as administrator".
    pause
    exit /b
)

:: Changes to the directory of the batch file (important when "Run as Admin")
cd /d "%~dp0"

set "EXE_PATH=x64\Release\Malwarebytes Unlimited Trial.exe"

if exist "%EXE_PATH%" (
    echo [+] The program is already compiled. Starting application...
    goto run_app
)

echo [*] Searching for MSBuild.exe in standard paths...
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
    echo [!] MSBuild.exe was not found in the standard paths.
    echo Please make sure Visual Studio or the Build Tools are installed.
    pause
    exit /b
)

echo [+] MSBuild found at: "%MSBUILD_PATH%"
echo [*] Compiling C++ project...

:: Try default compilation first
"%MSBUILD_PATH%" "Malwarebytes Unlimited Trial.vcxproj" /p:Configuration=Release /p:Platform=x64
if %errorlevel% equ 0 goto build_success

echo [!] Default compilation failed. Trying with PlatformToolset v145...
"%MSBUILD_PATH%" "Malwarebytes Unlimited Trial.vcxproj" /p:Configuration=Release /p:Platform=x64 /p:PlatformToolset=v145
if %errorlevel% equ 0 goto build_success

echo [!] Compilation failed. Please check the error messages above.
pause
exit /b

:build_success
echo [+] Compilation completed successfully!

:run_app
echo [*] Starting: "%EXE_PATH%"
"%EXE_PATH%"
pause
