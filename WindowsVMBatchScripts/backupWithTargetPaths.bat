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
SET starttime=%date%_%time%
SET dateformated=%date:~6,4%%date:~3,2%%date:~0,2%
SET timeformatted=%time:~0,2%%time:~3,2%%time:~6,2%
IF %time:~0,2% LSS 10 SET timeformatted=0%time:~1,1%%time:~3,2%%time:~6,2%
REM IF %time:~0,1%==1 ECHO ARG
Set timestampbackuppath=%backuppath%\%dateformated%-%timeformatted%
ECHO timestampbackuppath=%timestampbackuppath%
ECHO.

ECHO - 
ECHO **** Creating timestampbackupath ****
mkdir %timestampbackuppath%
IF EXIST %timestampbackuppath%\ (
	ECHO Created timestampbackupath
) ELSE (
	ECHO Error
	pause
	exit
)
ECHO.

REM ********************************************************
REM INSERT ALL TO BACKUP HERE
REM ********************************************************

ECHO -------------------------
ECHO --- Backup Test Data ----
ECHO -------------------------
call "%~dp0\packfolderswith7zip.bat" "R:\BackupScripts\WindowsVMBatchScripts\Tests\Packdir1 R:\BackupScripts\WindowsVMBatchScripts\Tests\Packdir2" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_Packdir12"
call "%~dp0\packfolderswith7zip.bat" "R:\BackupScripts\WindowsVMBatchScripts\Tests\Packdir1" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_Packdir1"
call "%~dp0\mysqldumpdatabase.bat" "beste" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_beste"

ECHO -------------------------------------------
ECHO --- Backup Folders Confluence and Jira ----
ECHO -------------------------------------------
REM CALL "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\Confluence" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_Confluence"
REM CALL "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\Jira" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_Jira"

ECHO -------------------------------
ECHO --- Backup Confluence Data ----
ECHO -------------------------------
REM CALL "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\ConfluenceHome" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_ConfluenceHome"
REM call "%~dp0\mysqldumpdatabase.bat" "confluence" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_confluence"

ECHO -------------------------
ECHO --- Backup Jira Data ----
ECHO -------------------------
REM CALL "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\JiraHome" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_JiraHome"
REM call "%~dp0\mysqldumpdatabase.bat" "jira" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_jira"

ECHO -----------------------------
ECHO --- Backup Teamcity Data ----
ECHO -----------------------------
REM SET teamcity="C:\ProgramData\JetBrains\TeamCity"
REM CALL "%~dp0\packfolderswith7zip.bat" "%teamcity%\config %teamcity%\lib %teamcity%\plugins %teamcity%\system" %timestampbackuppath% %szpath% "%dateformated%-%timeformatted%_Teamcity"
REM call "%~dp0\mysqldumpdatabase.bat" "teamcity" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_teamcity"

REM ********************************************************

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
ECHO.
ECHO **** HELP ****
ECHO Call the script like:
ECHO backupWithTargetPaths.bat "folderOf_7za.exe" "folderOf_mysqldump.exe" "existingbackuppath"
ECHO.
pause