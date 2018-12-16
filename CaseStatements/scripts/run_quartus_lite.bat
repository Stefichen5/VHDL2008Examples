:: (C) Stefan Mayrhofer
:: 15.12.2018

@ECHO OFF

SET retval=0

for %%i in (%TBNames%) do (
	%quartusLitePath% --flow compile %%i || CALL %Checkerror% "Error in quartus lite workflow"
)

:end