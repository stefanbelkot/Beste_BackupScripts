@ECHO OFF
set dirsToPack="R:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir1 R:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir2"
set movedir="R:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\BackupFolder"
set szpath="R:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
set packedname="test"
call packfolderswith7zip.bat %dirsToPack% %movedir% %szpath% %packedname%
call packfolderswith7zip.bat %dirsToPack% %movedir% %szpath%
set dirsToPack="C:\Temp\Packdir1"
call packfolderswith7zip.bat %dirsToPack% %movedir% %szpath%