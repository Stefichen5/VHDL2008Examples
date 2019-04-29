:: (C) Stefan Mayrhofer
:: 28.04.2019

@ECHO OFF

SET retval=0

for %%i in (%TBDNames%) do (
	%MY_VIVADO_PATH%\vivado.bat -mode batch -source vivado\sim.tcl
)

:end