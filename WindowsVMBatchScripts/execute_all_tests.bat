@ECHO OFF
SETLOCAL EnableExtensions EnableDelayedExpansion
SET startime=%date%_%time%
call backupWithTargetPaths_test.bat
call mysqldumpdatabase_test.bat
call packfolderswith7zip_test.bat
SET endtime=%date%_%time%
ECHO ------------------------------------------------------------------------
ECHO --- execute_all_tests.bat done
ECHO --- started: %startime%
ECHO --- ended: %endtime%
ECHO ------------------------------------------------------------------------