@ECHO OFF
REM - 
REM **** HELP for dumpdatabase.bat ****
REM Call the script like:
REM dumpdatabase.bat "database" "movedir" "folderOf_mysqldump.exe" "folderOf_7za.exe" "OptionalPackedName"
REM - 
set database="beste"
set mysqlpath="C:\xampp\mysql\bin"
set movedir="R:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\BackupFolder"
set szpath="R:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
set packedname="mysqldump"
call mysqldumpdatabase.bat %database% %movedir% %mysqlpath% %szpath% %packedname%
call mysqldumpdatabase.bat %database% %movedir% %mysqlpath% %szpath%