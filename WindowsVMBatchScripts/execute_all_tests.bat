@ECHO OFF
SETLOCAL EnableExtensions EnableDelayedExpansion
SET startime=%date%_%time%
REM Modify the paths in the following files according to your file system
call mysqldumpdatabase_test.bat
call packfolderswith7zip_test.bat
call backupWithTargetPaths_test.bat
SET endtime=%date%_%time%
ECHO ------------------------------------------------------------------------
ECHO --- execute_all_tests.bat done
ECHO --- started: %startime%
ECHO --- ended: %endtime%
ECHO ------------------------------------------------------------------------