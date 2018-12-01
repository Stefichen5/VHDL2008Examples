:: (C) Stefan Mayrhofer
:: V1: 01.12.2018

@ECHO OFF

:: Add VHDL filenames here
SET filenames=LogicalOperators.vhd tbLogicalOperators.vhd

::Add name of the testbench here
SET TBName=tbLogicalOperators

::----------------------------------------------------------
cls
SET Checkerror=../Verification_Scripts/Checkerror.bat
SET error=0

::change to directory of the file
pushd .
cd %~dp0

:: run all batch scripts in the scripts-subdir
for %%i in (scripts/*.bat) do (
	CALL scripts/%%i
	SET /A error=error+retval
	
	echo.
	echo.
	echo.
)

echo Script finished.
echo.
echo.
echo.

if %error% GTR 0 (
	echo [91mThere were errors in %error% scripts[0m
) else (
	echo [92mThere were no errors[0m
)

POPD

PAUSE