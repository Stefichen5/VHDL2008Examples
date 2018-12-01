@ECHO OFF

::change to directory of the file
pushd .
cd %~dp0

ECHO Starting VCOM

vlib work
vcom -2008 ../LogicalOperators.vhd
vcom -2008 ../tbLogicalOperators.vhd

ECHO Starting simulation

vsim -c -do modelsim.do tbLogicalOperators

ECHO Modelsim simulation finished

:: restore old working dir
POPD
