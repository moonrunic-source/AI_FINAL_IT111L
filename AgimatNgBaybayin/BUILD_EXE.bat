@echo off
cd /d "%~dp0"

echo Preparing font...
if not exist "Assets" mkdir "Assets"
copy /Y "*.ttf" "Assets\" >nul 2>&1

set FONTCOUNT=0
for %%F in ("Assets\*.ttf") do set /a FONTCOUNT+=1
if %FONTCOUNT% equ 0 goto nofont
if %FONTCOUNT% gtr 1 echo WARNING: more than one .ttf in Assets. Only the first one is used.

echo Building Agimat ng Baybayin...
dotnet publish AgimatNgBaybayin.csproj -c Release -o "%~dp0Game"
if errorlevel 1 goto builderror

echo Done! Your game is at: %~dp0Game\AgimatNgBaybayin.exe
start "" "%~dp0Game"
pause
exit /b 0

:nofont
echo ERROR: no .ttf font found. Put your font file next to this file or in the Assets folder.
pause
exit /b 1

:builderror
echo Build failed. Make sure the .NET 8 SDK is installed.
pause
exit /b 1