@ECHO OFF
ECHO -----------------------------------------
ECHO --- Testing the zip script  ---
ECHO -----------------------------------------
ECHO.
REM Modify the paths according to your file system
set movedir="C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\BackupFolder"
set szpath="C:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
set packedname="Packdir12"

set dirToPack="C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir1"
call packfolderswith7zip.bat %dirToPack% %movedir% %szpath% 0 %packedname%
call packfolderswith7zip.bat %dirToPack% %movedir% %szpath% 0

set dirToPack="C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\Packdir2"
call packfolderswith7zip.bat %dirToPack% %movedir% %szpath% 0 %packedname%
call packfolderswith7zip.bat %dirToPack% %movedir% %szpath% 0
pause