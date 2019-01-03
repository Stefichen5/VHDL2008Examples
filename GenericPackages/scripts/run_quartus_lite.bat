:: (C) Stefan Mayrhofer
:: 15.12.2018

@ECHO OFF

SET retval=0

for %%i in (%TBDNames%) do (
 	%quartusLitePath% --flow compile quartus_lite\\%%i || CALL %Checkerror% "Error in quartus lite workflow"
)

:end