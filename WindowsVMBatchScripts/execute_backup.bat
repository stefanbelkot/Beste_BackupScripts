@ECHO OFF
SETLOCAL EnableExtensions EnableDelayedExpansion

SET startime=%date%_%time%

SET szpath="C:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
SET mysqlpath="C:\PROGRA~1\MySQL\MYSQLS~1.7\bin"
SET backuppath="C:\OneDrive\VMWindowsBackup"

ECHO -----------------------------
ECHO --- Stopping services ----
ECHO -----------------------------
sc stop "Apache"
sc stop "CONFLUENCE"
sc stop "JIRASoftware130119125822"
sc stop "hMailServer"
sc stop "TeamCity Server"
timeout /t 10

call backupWithTargetPathsProductive.bat %szpath% %mysqlpath% %backuppath%

ECHO -----------------------------
ECHO --- Restart services ----
ECHO -----------------------------
sc start "MySQL57"
sc start "Apache"
sc start "CONFLUENCE"
sc start "JIRASoftware130119125822"
sc start "hMailServer"
sc start "TeamCity Server"

SET endtime=%date%_%time%
ECHO ------------------------------------------------------------------------
ECHO --- execute_backup.bat done
ECHO --- started: %startime%
ECHO --- ended: %endtime%
ECHO ------------------------------------------------------------------------
pause