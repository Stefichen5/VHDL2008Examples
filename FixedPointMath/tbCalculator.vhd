library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use IEEE.fixed_pkg.all;

use std.env.all;

entity tbCalculator is
end entity tbCalculator;

architecture Bhv of tbCalculator is
	constant cWaitTime : time := 5 ns;
	constant cHigh : natural := 4;
	constant cLow : integer := -2;
	
	signal iA_fix, iB_Fix : sfixed(cHigh downto cLow) := "0000000";
	signal oRes_fix : sfixed(cHigh+1 downto cLow) := "00000000";
	signal iA_float, iB_float, oRes_float : float(cHigh downto cLow) := "0000000";
begin
	UUT_fixed : entity work.FixedPointCalculator
		port map(
			iA   => iA_fix,
			iB   => iB_fix,
			oRes => oRes_fix
		);
	
	UUT_float : entity work.FloatPointCalculator
		port map(
			iA   => iA_float,
			iB   => iB_float,
			oRes => oRes_float
		);
	
	Stimul_fixed : process is
	begin
		--------------------------------------------------
		--Test fix
		--------------------------------------------------
		wait until oRes_fix = 0;
		
		iA_fix <= "0000110" after cWaitTime;
		iB_fix <= "0000110" after cWaitTime;
		wait until oRes_fix'EVENT;
		
		assert oRes_fix = 3 severity failure;
		
		iA_fix <= "0000000" after cWaitTime;
		wait until oRes_fix'EVENT;
		assert oRes_fix = 1.5 severity failure;
		
		--------------------------------------------------
		--Test float
		--------------------------------------------------
		iA_float <= "0000110" after cWaitTime;
		iB_float <= "0000110" after cWaitTime;
		wait until oRes_float'EVENT;
		
		assert oRes_float = 3 severity failure;
		
		iA_float <= "0000000";
		wait until oRes_float'EVENT;
		
		assert oRes_float = 1.5 severity failure;
		
		
		--------------------------------------------------
		--done
		--------------------------------------------------
		report "testbench finished" severity note;
		
		finish;
	end process;

end architecture Bhv;
