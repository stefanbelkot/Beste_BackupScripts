@ECHO OFF
ECHO -----------------------------------------
ECHO --- Testing the parent script  ---
ECHO --- for all backup is working  ---
ECHO -----------------------------------------
ECHO.
REM Modify the paths according to your file system
SET szpath="C:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
SET mysqlpath="C:\xampp\mysql\bin"
SET backuppath="C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\BackupFolder"
call backupWithTargetPathsTest.bat %szpath% %mysqlpath% %backuppath%
pause