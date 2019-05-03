@ECHO OFF

Rem -- Prepare the Command Processor
SETLOCAL EnableExtensions EnableDelayedExpansion
Title dumpdatabase.bat
ECHO -------------------------------------
ECHO --- mysqldumpdatabase.bat started ---
ECHO -------------------------------------

IF "%1"=="" GOTO help
IF "%2"=="" GOTO help
IF "%3"=="" GOTO help
IF "%4"=="" GOTO help

set database=%1
set movedir=%2
set mysqlpath=%3
set szpath=%4
set packedname=%5
IF NOT EXIST %szpath%\ GOTO foldernotexists
IF NOT EXIST %mysqlpath%\ GOTO foldernotexists
IF NOT EXIST %backuppath%\ GOTO foldernotexists
IF NOT EXIST %szpath%\7za.exe GOTO filenotexists
IF NOT EXIST %mysqlpath%\mysqldump.exe GOTO filenotexists
REM --------- Set path of mysql bin directory (change as required) ----------
set path="%mysqlpath%";"%szpath%";%path%
REM ---------------------------------------------------------------------------

IF "%packedname%"=="" set packedname=%database%
REM to zip only files change "%zipdir%" to "%zipdir%\*.*", "%zipdir%\*.txt", etc.
ECHO.
ECHO Dumping database to "%movedir%\%packedname%.7z"
ECHO.
REM mysqldump -uroot -proot --databases %database% > "%movedir%\%TODAY%_%database%.sql" 
mysqldump -uroot -proot --max_allowed_packet=512M --databases %database% | 7za a -si "%movedir%\%packedname%.7z"

ECHO ---------------------------------------
ECHO --- mysqldumpdatabase.bat completed ---
ECHO ---------------------------------------
ECHO.
EXIT /B 0

:foldernotexists
ECHO.
ECHO **** One or more of needed folders not exists: ****
ECHO szpath=%szpath%
ECHO mysqlpath=%mysqlpath%
ECHO backuppath=%backuppath%
GOTO help
ECHO.

:filenotexists
ECHO.
ECHO **** One or more of needed executeables not exists: ****
ECHO szpath=%szpath%\7za.exe
ECHO mysqlpath=%mysqlpath%\mysqldump.exe
GOTO help
ECHO.

:help
ECHO - 
ECHO **** HELP for dumpdatabase.bat ****
ECHO Call the script like:
ECHO dumpdatabase.bat "database" "movedir" "folderOf_mysqldump.exe" "folderOf_7za.exe" "OptionalPackedName"
ECHO - 
pause