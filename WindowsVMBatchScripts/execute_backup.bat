@ECHO OFF
SETLOCAL EnableExtensions EnableDelayedExpansion

SET startime=%date%_%time%

SET szpath="R:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
SET mysqlpath="C:\xampp\mysql\bin"
SET backuppath="C:\Users\Stefan\OneDrive\BackupTest"
call backupWithTargetPaths.bat %szpath% %mysqlpath% %backuppath%

SET endtime=%date%_%time%
ECHO ------------------------------------------------------------------------
ECHO --- execute_backup.bat done
ECHO --- started: %startime%
ECHO --- ended: %endtime%
ECHO ------------------------------------------------------------------------