@ECHO OFF

::change to directory of the file
pushd .
cd %~dp0

ECHO Starting analysis

ghdl -a --std=08 ../LogicalOperators.vhd
ghdl -a --std=08 ../tbLogicalOperators.vhd

ECHO Starting elaboration and run

ghdl --elab-run --std=08 tbLogicalOperators

ECHO GHDL simulation finished

:: restore old working dir
popd