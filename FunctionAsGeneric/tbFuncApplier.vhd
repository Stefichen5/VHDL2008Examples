library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

use work.PackGenericFunctions.all;

entity tbFuncApplier is
end entity tbFuncApplier;

architecture Bhv of tbFuncApplier is
	constant cWaitTime : time := 5 ns;
	signal iDataA_natural, iDataB_natural, oData_natural : natural := 0;
	signal iDataA_ulogic, iDataB_ulogic, oData_ulogic : std_ulogic := '0';
begin
	UUT_Natural : entity work.FunctionApplier
		generic map(
			gaType => natural,
			my_generic_function => natural_plus
		)
		port map(
			iDataA => iDataA_natural,
			iDataB => iDataB_natural,
			oData  => oData_Natural
		);
	
	UUT_Ulogic: entity work.FunctionApplier
		generic map(
			gaType => std_ulogic,
			my_generic_function => std_ulogic_and
		)
		port map(
			iDataA => iDataA_ulogic,
			iDataB => iDataB_ulogic,
			oData  => oData_ulogic
		);
	
	Stimul : process is
	begin
		iDataA_natural <= 0;
		iDataB_natural <= 0;
		iDataA_ulogic <= '0';
		iDataB_ulogic <= '0';
		wait for cWaitTime;
		
		assert oData_natural = 0 severity failure;
		assert oData_ulogic = '0' severity failure;
		
		iDataA_natural <= 5 after cWaitTime;
		iDataB_natural <= 5 after cWaitTime;
		iDataA_ulogic <= '1' after cWaitTime;
		iDataB_ulogic <= '1' after cWaitTime;
		
		wait until oData_natural'EVENT;
		
		assert oData_natural = 10 severity failure;
		assert oData_ulogic = '1' severity failure;
		
		report "testbench finished" severity note;
		
		finish;
	end process;
end architecture Bhv;
