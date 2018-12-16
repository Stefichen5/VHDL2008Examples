:: (C) Stefan Mayrhofer
:: 01.12.2018

@ECHO OFF

SET retval=0

ECHO Starting VCOM

%ModelsimPath%\vlib.exe work

for %%i in (%filenames%) do (
	%ModelsimPath%\vcom.exe -2008 %%i || CALL %Checkerror% "Error in VCOM analysis"
)

ECHO Starting simulation

for %%i in (%TBNames%) do (
	%ModelsimPath%\vsim.exe -c -do scripts/modelsim.do %%i || CALL %Checkerror% "Error in VSIM for TB %%i"
)

ECHO [92mModelsim simulation finished successfully[0m

:end