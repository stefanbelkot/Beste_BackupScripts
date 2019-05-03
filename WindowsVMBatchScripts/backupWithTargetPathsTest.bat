@ECHO OFF

Rem -- Prepare the Command Processor
SETLOCAL EnableExtensions EnableDelayedExpansion
Title backupWithTargetPaths.bat
ECHO -----------------------------------------
ECHO --- backupWithTargetPaths.bat started ---
ECHO -----------------------------------------


IF "%1"=="" GOTO help
IF "%2"=="" GOTO help
IF "%3"=="" GOTO help

REM Set variables
ECHO.
ECHO **** Set variables ****
SET szpath=%1
SET mysqlpath=%2
Set backuppath=%3
IF NOT EXIST %szpath%\ GOTO foldernotexists
IF NOT EXIST %mysqlpath%\ GOTO foldernotexists
IF NOT EXIST %backuppath%\ GOTO foldernotexists
IF NOT EXIST %szpath%\7za.exe GOTO filenotexists
IF NOT EXIST %mysqlpath%\mysqldump.exe GOTO filenotexists
ECHO szpath=%szpath%
ECHO mysqlpath=%mysqlpath%
ECHO backuppath=%backuppath%
ECHO.


ECHO.
ECHO **** Calculating Timestamp for Backuppath ****
ECHO **** Only works for date format dd.mm.yyyy and time format hh:mm:ss ****
SET starttime=%date%_%time%
ECHO **** The date and time to extract folder name from is: %starttime% ****
SET dateformated=%date:~6,4%%date:~3,2%%date:~0,2%
SET timeformatted=%time:~0,2%%time:~3,2%%time:~6,2%
IF %time:~0,2% LSS 10 SET timeformatted=0%time:~1,1%%time:~3,2%%time:~6,2%
Set timestampbackuppath=%backuppath%\%dateformated%-%timeformatted%
ECHO timestampbackuppath=%timestampbackuppath%
ECHO.

ECHO. 
ECHO **** Creating timestampbackupath ****
mkdir %timestampbackuppath%
IF EXIST %timestampbackuppath%\ (
	ECHO Created timestampbackupath at "%timestampbackuppath%"
) ELSE (
	ECHO Error
	pause
	exit
)
ECHO.

REM ********************************************************
REM INSERT ALL TO BACKUPS FROM HERE
REM ********************************************************

REM ECHO -------------------------
REM ECHO --- Backup Test Data ----
REM ECHO -------------------------
call "%~dp0\packfolderswith7zip.bat" "C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir1" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Packdir12"
call "%~dp0\packfolderswith7zip.bat" "C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir2" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Packdir12"
call "%~dp0\packfolderswith7zip.bat" "C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir1" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Packdir1"
call "%~dp0\packfolderswith7zip.bat" "C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir2" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Packdir2"
call "%~dp0\mysqldumpdatabase.bat" "beste_test" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_beste_test"

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
ECHO.
ECHO **** HELP ****
ECHO Call the script like:
ECHO backupWithTargetPaths.bat "folderOf_7za.exe" "folderOf_mysqldump.exe" "existingbackuppath"
ECHO.
pause