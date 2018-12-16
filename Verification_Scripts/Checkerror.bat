@ECHO OFF

:: Print message in red for better visibility
echo [91m%~1[0m

SET retval=1
(GOTO) 2>NUL & GOTO end