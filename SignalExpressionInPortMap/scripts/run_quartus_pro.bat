:: (C) Stefan Mayrhofer
:: 16.12.2018

@ECHO OFF

SET retval=0

for %%i in (%TBDNames%) do (
	%quartusProPath% --flow compile quartus_pro\\%%i || CALL %Checkerror% "Error in quartus pro workflow"
)

:end