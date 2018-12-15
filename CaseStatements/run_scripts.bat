:: (C) Stefan Mayrhofer
:: V1: 02.12.2018

@ECHO OFF

:: Add VHDL filenames here
:: CaseDontCare are unfinished and not very well thought through examples. Don't use them 
:: CaseDontCare.vhd tbCaseDontCare.vhd
SET filenames=CounterWithReset.vhd tbCounterWithReset.vhd

::Add names of the testbenches here
::tbCaseDontCare
SET TBNames=tbCounterWithReset

::Add path to quartus lite shell executable
SET quartusLitePath=%MY_QUARTUS_PATH%\quartus_sh.exe

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