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
	
	signal iA_fix, iB_Fix : sfixed(cHigh downto cLow) := "1111100";
	signal oRes_fix : sfixed(cHigh downto cLow) := "0000000";
	signal iA_float, iB_float, oRes_float : float(5 downto -10);
	
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
		variable valueA: ufixed(4 downto -3) := "01000100";
		variable valueB: ufixed(3 downto -4) := "00000000";
	begin
		iA_float <= to_float(0, iA_float);
		iB_float <= to_float(0, iB_float);
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
		
		-- convert to sfixed (ufixed is also possible)
		iA_fix <= to_sfixed(1.22, iA_fix);
		iB_fix <= to_sfixed(2.75, cHigh, cLow);
		
		report "fixed point test finished" severity note;
		--------------------------------------------------
		--Test float
		--------------------------------------------------
		iA_float <= to_float(1.5, iA_float) after cWaitTime;
		iB_float <= to_float(1.5, iB_float) after cWaitTime;
		wait until oRes_float'EVENT;
		
		assert oRes_float = 3 severity failure;
		
		iA_float <= to_float(0, iA_float) after cWaitTime;
		iB_float <= "1010101010101010" after cWaitTime;
		iB_float <= to_float(1/5, iB_float) after cWaitTime;
		wait until oRes_float'EVENT;
		
		assert oRes_float = 1/5 severity failure;
		
		/* Illegal:
			Res <= A + "1010101010"; 
		*  Legal:
			Res <= A + 1;
			Res <= A + 1.23;
		* */
		
		--------------------------------------------------
		--test other things
		--------------------------------------------------
		report "valueA is: " & to_string(valueA);
		valueB := valueA;
		report "without resizing, valueB is: " & to_string(valueB);
		valueB := resize(valueA, valueB);
		report "After resizing, valueB is: " & to_string(valueB);

		assert valueA = valueB severity failure;
		
		wait for cWaitTime;
		--------------------------------------------------
		--done
		--------------------------------------------------
		report "testbench finished" severity note;
		
		finish;
	end process;

end architecture Bhv;
