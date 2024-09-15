@echo off
TITLE LoL AutoBatch HealthbarFix
COLOR 0A
CLS

:executeable
CLS
ECHO ________________________________________________________________________________________________________________________
ECHO.
ECHO Selected Executeable: (not selected)
ECHO.
ECHO Selected Directory: (not selected)
ECHO ________________________________________________________________________________________________________________________
ECHO.
ECHO.
ECHO Paste the path to the FixHealthBar executeable. (https://github.com/GuiSaiUwU/FixHealthBar/releases/)
ECHO Use the "Copy as path" in the Windows context menu (right-click on the .exe)
ECHO.
SET FixEXE=
SET /p FixEXE=Select the FixHealthBar.exe: 
IF '%FixEXE%'=='' GOTO executeable

:directory
CLS
ECHO ________________________________________________________________________________________________________________________
ECHO.
ECHO Selected Executeable: %FixEXE%
ECHO.
ECHO Selected Directory: (not selected)
ECHO ________________________________________________________________________________________________________________________
ECHO.
ECHO.
ECHO Paste the path to the "installed" folder. (...\cslol-manager\installed)
ECHO Use the "Copy as path" in the Windows context menu (right-click on the folder)
ECHO.
SET Install_Path=
SET /p Install_Path=Select the "installed" folder: 
IF '%Install_Path%'=='' GOTO directory

:start
CLS
ECHO ________________________________________________________________________________________________________________________
ECHO.
ECHO Selected Executeable: %FixEXE%
ECHO.
ECHO Selected Directory: %Install_Path%
ECHO ________________________________________________________________________________________________________________________
ECHO.
IF NOT '%choice%'=='' ECHO "%choice%" is invalid.
ECHO.
ECHO You are about to modify the bin data of ALL the items in the specified directory.
ECHO Make sure you backup the selected folder in case something goes wrong!
ECHO.
ECHO Are you sure you want to continue?
SET choice=
SET /p choice=[Y/N]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='Y' GOTO yes
IF '%choice%'=='y' GOTO yes
IF '%choice%'=='N' GOTO no
IF '%choice%'=='n' GOTO no
IF '%choice%'=='' GOTO return
GOTO start

:yes
SETLOCAL enableextensions enabledelayedexpansion

SET /A ItemCount=0
FOR /D %%a in (%Install_Path%\*) do (
    SET /a ItemCount=!ItemCount!+1
)

SET /a Count=0
FOR /D %%a in (%Install_Path%\*) do (
  CLS
  SET /a Count+=1
  ECHO.
  ECHO Item [!Count!/!ItemCount!]
  ECHO.
  ECHO "%%a"
  ECHO.
  START "" /b /wait cmd /c "%FixEXE% "%%a""
  >"%temp%\tmp.vbs" echo wscript.sleep 50 & cscript //nologo "%temp%\tmp.vbs" & del "%temp%\tmp.vbs"
)
CLS
ECHO _________________________________________
ECHO.
ECHO Program completed.
ECHO Items modified: !ItemCount!.
ECHO _________________________________________
ECHO.
ENDLOCAL
PAUSE
EXIT

:no
CLS
ECHO _________________________________________
ECHO.
ECHO Program aborted.
ECHO Please start a new instance to try again.
ECHO _________________________________________
ECHO.
PAUSE
EXIT

:return
CLS
GOTO start

By Kjell003
V1.0.0