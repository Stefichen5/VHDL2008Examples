:: (C) Stefan Mayrhofer
:: V1: 02.12.2018

@ECHO OFF

:: Add VHDL filenames here
SET filenames=ConditionalOperatorComplex.vhd ConditionalOperatorMux.vhd tbConditionalOperatorComplex.vhd tbConditionalOperatorMux.vhd

::Add names of the testbenches here
::tbCaseDontCare
SET TBNames=tbConditionalOperatorMux tbConditionalOperatorComplex
SET TBDNames=tbdConditionalOperator

::Add path to executables
SET GHDLPath=%MY_GHDL_PATH%\ghdl.exe
SET ModelsimPath=%MY_MODELSIM_PATH%\
SET quartusLitePath=%MY_QUARTUS_PATH%\quartus_sh.exe
SET quartusProPath=%MY_QUARTUS_PRO_PATH%\quartus_sh.exe

::Set device families for quartus synthesis
SET quartus_lite_family=CycloneV
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