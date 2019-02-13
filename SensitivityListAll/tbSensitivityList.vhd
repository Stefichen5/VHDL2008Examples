library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbSensitivityList is
end entity tbSensitivityList;

architecture Bhv of tbSensitivityList is
	constant cWaitTime : time := 1 ns;
	
	signal iA, iB, iC, oRes_New, oRes_Old : std_ulogic := '0';
begin
	UUT_new : entity work.SensitivityList(Rtl_New)
		port map(
			iA   => iA,
			iB   => iB,
			iC   => iC,
			oRes => oRes_New
		);

	UUT_old : entity work.SensitivityList(Rtl_Old)
		port map(
			iA   => iA,
			iB   => iB,
			iC   => iC,
			oRes => oRes_Old
		);	
	
	Stimul : process is
	begin
		iA <= '0';
		iB <= '0';
		iC <= '0';
		wait for 0 ns;
		assert (oRes_New = (iA XOR iB XOR iC)) report "Wrong result" severity failure;
		
		--start test
		iA <= '1';
		wait for cWaitTime;
		assert (oRes_New = (iA XOR iB XOR iC)) report "Wrong result" severity failure;
		
		iB <= '1';
		wait for cWaitTime;
		assert (oRes_New = (iA XOR iB XOR iC)) report "Wrong result" severity failure;
		
		iC <= '1';
		wait for cWaitTime;
		assert (oRes_New = (iA XOR iB XOR iC)) report "Wrong result" severity failure;
		
		iB <= '0';
		wait for cWaitTime;
		assert (oRes_New = (iA XOR iB XOR iC)) report "Wrong result" severity failure;
		
		iA <= '0';
		wait for cWaitTime;
		assert (oRes_New = (iA XOR iB XOR iC)) report "Wrong result" severity failure;
		
		report "Testbench finished" severity note;
		finish;
	end process;
	
	assert (oRes_Old = oRes_New) report "Differing results" severity failure;
end architecture Bhv;
