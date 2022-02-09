@echo off
SET THEFILE=C:\Users\Marcelo\Desktop\ProyectoUltimo\projectConversionBD.exe
echo Linking %THEFILE%
C:\UltimoLazarus\fpc\3.2.0\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\Users\Marcelo\Desktop\ProyectoUltimo\projectConversionBD.exe C:\Users\Marcelo\Desktop\ProyectoUltimo\link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
