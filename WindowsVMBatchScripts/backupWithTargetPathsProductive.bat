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
REM call "%~dp0\packfolderswith7zip.bat" "R:\BackupScripts\WindowsVMBatchScripts\Tests\Packdir1 R:\BackupScripts\WindowsVMBatchScripts\Tests\Packdir2" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Packdir12"
REM call "%~dp0\packfolderswith7zip.bat" "R:\BackupScripts\WindowsVMBatchScripts\Tests\Packdir1" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Packdir1"
REM call "%~dp0\mysqldumpdatabase.bat" "beste_test" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_beste"

REM Backup first file systems to give services time to stop running
ECHO -----------------------------
ECHO --- CertifyTheWeb ----
ECHO -----------------------------
CALL "%~dp0\packfolderswith7zip.bat" "C:\ProgramData\Certify" %timestampbackuppath% %szpath% 3 "%dateformated%-%timeformatted%_CertifyTheWeb"
REM ********************************************************

ECHO -----------------------------
ECHO --- Desktop ----
ECHO -----------------------------
CALL "%~dp0\packfolderswith7zip.bat" "C:\Users\Administrator\Desktop" %timestampbackuppath% %szpath% 3 "%dateformated%-%timeformatted%_Desktop"
REM ********************************************************


REM Backup service depending files, kill the services if still running so we can access all the files
ECHO -----------------------------
ECHO --- Backup hMailServer ----
ECHO -----------------------------
taskkill /F /FI "SERVICES eq hMailServer"
CALL "%~dp0\packfolderswith7zip.bat" "C:\PROGRA~2\hMailServer" %timestampbackuppath% %szpath% 5 "%dateformated%-%timeformatted%_HMailServer"
REM ********************************************************

ECHO -------------------------------------------
ECHO --- Backup Confluence ----
ECHO -------------------------------------------
taskkill /F /FI "SERVICES eq CONFLUENCE"
call "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\ConfluenceHome" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Confluence"
call "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\Confluence" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Confluence"
call "%~dp0\mysqldumpdatabase.bat" "confluence" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_confluence"
REM ********************************************************

ECHO -------------------------------------------
ECHO --- Backup Jira ----
ECHO -------------------------------------------
taskkill /F /FI "SERVICES eq JIRASoftware130119125822"
call "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\JiraHome" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Jira"
call "%~dp0\packfolderswith7zip.bat" "C:\Atlassian\Jira" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Jira"
call "%~dp0\mysqldumpdatabase.bat" "jira" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_jira"
REM ********************************************************

ECHO -----------------------------
ECHO --- Backup Teamcity ----
ECHO -----------------------------
taskkill /F /FI "SERVICES eq "TeamCity Server""
SET teamcity="C:\ProgramData\JetBrains\TeamCity"
CALL "%~dp0\packfolderswith7zip.bat" "%teamcity%\config" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Teamcity"
CALL "%~dp0\packfolderswith7zip.bat" "%teamcity%\lib " %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Teamcity"
CALL "%~dp0\packfolderswith7zip.bat" "%teamcity%\plugins" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Teamcity"
CALL "%~dp0\packfolderswith7zip.bat" "%teamcity%\system" %timestampbackuppath% %szpath% 0 "%dateformated%-%timeformatted%_Teamcity"
call "%~dp0\mysqldumpdatabase.bat" "teamcity" %timestampbackuppath% %mysqlpath% %szpath% "%dateformated%-%timeformatted%_Database_teamcity"
REM ********************************************************


REM Last backup the database files for possibly faster reinstallation than by sqldumbs (sqldumbs are the fallback solution)
ECHO -----------------------------
ECHO --- CompleteMySqlDataFolder ----
ECHO -----------------------------
sc stop "MySQL57"
timeout /t 20
taskkill /F /FI "SERVICES eq MySQL57"
CALL "%~dp0\packfolderswith7zip.bat" "C:\ProgramData\MySQL\MySQL Server 5.7\" %timestampbackuppath% %szpath% 3 "%dateformated%-%timeformatted%_CompleteMySqlDataFolder"
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