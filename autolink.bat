@echo off
for /d %%I in ("*BP") do set name_bp=%%~nxI
for /d %%I in ("*RP") do set name_rp=%%~nxI

set minecraft=%UserProfile%\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang

set destination_bp="%minecraft%\development_behavior_packs\%name_bp%"
set destination_rp="%minecraft%\development_resource_packs\%name_rp%"

set source_bp="%~dp0%name_bp%"
set source_rp="%~dp0%name_rp%"

for %%i in (%source_bp%) do set attribs=%%~ai
if not x%attribs:l=%==x%attribs% (
  GOTO :ERROR
)
for %%i in (%source_rp%) do set attribs=%%~ai
if not x%attribs:l=%==x%attribs% (
  GOTO :ERROR
)

rmdir /q /s %destination_bp%
rmdir /q /s %destination_rp%

mkdir %destination_bp%
mkdir %destination_rp%

xcopy %source_bp% %destination_bp% /E
xcopy %source_rp% %destination_rp% /E

rmdir /q /s %source_bp%
rmdir /q /s %source_rp%

mklink /J %source_bp% %destination_bp%
mklink /J %source_rp% %destination_rp%

pause
exit

:ERROR
echo [!] Symlink already exist!
pause
exit