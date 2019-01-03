:: (C) Stefan Mayrhofer
:: 01.12.2018

@ECHO OFF

SET retval=0

ECHO Starting analysis

for %%i in (%filenames%) do (
	%GHDLPath% -a --std=08 %%i || CALL %Checkerror% "Error in GHDL analysis"
)

ECHO Starting elaboration and run

for %%i in (%TBNames%) do (
	%GHDLPath% --elab-run --std=08 %%i || CALL %Checkerror% "Error in elaboration and run of TB %%i"
)

ECHO [92mGHDL simulation passed successfully[0m

:end