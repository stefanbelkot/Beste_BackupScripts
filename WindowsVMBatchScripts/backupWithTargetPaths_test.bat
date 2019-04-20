@ECHO OFF
SET szpath="R:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
SET mysqlpath="C:\xampp\mysql\bin"
SET backuppath="R:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\BackupFolder"
call backupWithTargetPaths.bat %szpath% %mysqlpath% %backuppath%