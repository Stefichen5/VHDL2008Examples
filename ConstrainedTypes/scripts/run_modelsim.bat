:: (C) Stefan Mayrhofer
:: 01.12.2018

@ECHO OFF

SET retval=0

ECHO Starting VCOM

vlib work
for %%i in (%filenames%) do (
	vcom -2008 %%i || CALL %Checkerror% "Error in VCOM analysis"
)

ECHO Starting simulation

for %%i in (%TBNames%) do (
::	vsim -c -do scripts/modelsim.do %%i || CALL %Checkerror% "Error in VSIM for TB %%i"
	vsim -c -do scripts/modelsim.do %%i || ECHO %ErrorLevel%
)

ECHO [92mModelsim simulation finished successfully[0m

:end