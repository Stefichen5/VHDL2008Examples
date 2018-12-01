@ECHO OFF

:: run all batch scripts in the scripts-subdir
for %%i in (scripts/*.bat) do call scripts/%%i

PAUSE