@ECHO OFF

Rem -- Prepare the Command Processor
SETLOCAL EnableExtensions EnableDelayedExpansion
Title packfolderswith7zip.bat
ECHO ---------------------------------------
ECHO --- packfolderswith7zip.bat started ---
ECHO ---------------------------------------

IF "%~1"=="" GOTO help
IF "%2"=="" GOTO help
IF "%3"=="" GOTO help
IF "%4"=="" GOTO help

set dirsToPack=%~1
set movedir=%2
set szpath=%3
REM for compressionlevels see https://sevenzip.osdn.jp/chm/cmdline/switches/method.htm#ZipX 0:copy, 5:normal
set compressionLevel=%4
set packedname=%5
IF NOT EXIST %szpath%\ GOTO foldernotexists
IF NOT EXIST %movedir%\ GOTO foldernotexists
IF NOT EXIST %szpath%\7za.exe GOTO filenotexists
ECHO.
ECHO **** Set variables ****
ECHO dirsToPack=%dirsToPack%
ECHO movedir=%movedir%
ECHO szpath=%szpath%
ECHO packedname=%packedname%
ECHO.
REM --------- Add path of console version 7-Zip to PATH ----------
set path="%szpath%";%path%
REM ---------------------------------------------------------------------------

ECHO Zipping all contents of "%dirsToPack%" and moving archive to "%movedir%"
ECHO.

IF "%packedname%"=="" for %%f in (%dirsToPack%) do set packedname=%%~nxf

REM Above is faster but needs double space
REM 7za a -tzip "%movedir%\%myfolder%_%TODAY%.zip" -r "%dirsToPack%\*.*" -mx5
ECHO 7za a "%movedir%\%packedname%.7z" "%dirsToPack%" -mmt=4 -mx=%compressionLevel%
7za a "%movedir%\%packedname%.7z" "%dirsToPack%" -mmt=4 -mx=%compressionLevel%
ECHO -----------------------------------------
ECHO --- packfolderswith7zip.bat completed ---
ECHO -----------------------------------------
ECHO.
EXIT /B 0

:end
ECHO.
ECHO dirsToPack, movedir don't exist, or error in 7-Zip console version path
ECHO Create dirsToPack, movedir, or correct executable path above
ECHO Exiting script
ECHO EXIT /B 0

:foldernotexists
ECHO - 
ECHO **** One or more of needed folders not exists: ****
ECHO movedir=%movedir%
ECHO szpath=%szpath%
GOTO help
ECHO - 

:filenotexists
ECHO - 
ECHO **** One or more of needed executeables not exists: ****
ECHO szpath=%szpath%\7za.exe
GOTO help
ECHO - 

:help
ECHO - 
ECHO **** HELP for packfolderswith7zip.bat ****
ECHO Call the script like:
ECHO packfolderswith7zip.bat "dirsToPack" "movedir" "folderOf_7za.exe" "compressionLevel [0 | 1 | 3 | 5 | 7 | 9 ]" "OptionalPackedName"
ECHO - 
pause