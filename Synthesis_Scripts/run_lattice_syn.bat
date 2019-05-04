:: (C) Stefan Mayrhofer
:: 04.05.2019

@ECHO OFF

SET retval=0

for %%i in (%TBDNames%) do (
	%MY_LATTICE_PATH%\pnmainc.exe lattice\synthesis.tcl || CALL %Checkerror% "Error in lattice pro workflow"
)

:end