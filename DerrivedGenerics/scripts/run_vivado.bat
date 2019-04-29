:: (C) Stefan Mayrhofer
:: 28.04.2019

rem @ECHO OFF

SET retval=0

for %%i in (%TBDNames%) do (
	%MY_VIVADO_PATH%\vivado.bat -mode batch -source vivado\sim.tcl || CALL %Checkerror% "Error in vivado simulation"
	%MY_VIVADO_PATH%\vivado.bat -mode batch -source vivado\synth.tcl || CALL %Checkerror% "Error in vivado synthesis workflow"
)

:end