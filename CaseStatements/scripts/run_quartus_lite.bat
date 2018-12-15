:: (C) Stefan Mayrhofer
:: 15.12.2018

@ECHO OFF

SET retval=0

rem SET TBNames=tbCounterWithReset
rem SET quartusLitePath=%MY_QUARTUS_PATH%\quartus_sh.exe

for %%i in (%TBNames%) do (
	%quartusLitePath% --flow compile %%i || CALL %Checkerror% "Error in quartus lite workflow"
)

:end