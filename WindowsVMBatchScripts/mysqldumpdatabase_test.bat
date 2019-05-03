@ECHO OFF
REM - 
REM **** HELP for dumpdatabase.bat ****
REM Call the script like:
REM dumpdatabase.bat "database" "movedir" "folderOf_mysqldump.exe" "folderOf_7za.exe" "OptionalPackedName"
REM - 
ECHO -----------------------------------------
ECHO --- Testing the mysqldump script  ---
ECHO -----------------------------------------
ECHO.
REM Modify the paths + existing database according to your file system
set database="beste_test"
set mysqlpath="C:\xampp\mysql\bin"
set movedir="C:\Beste_BackupScripts\WindowsVMBatchScripts\Tests\BackupFolder"
set szpath="C:\Beste_BackupScripts\WindowsVMBatchScripts\7za"
set packedname="mysqldump"
call mysqldumpdatabase.bat %database% %movedir% %mysqlpath% %szpath% %packedname%
call mysqldumpdatabase.bat %database% %movedir% %mysqlpath% %szpath%