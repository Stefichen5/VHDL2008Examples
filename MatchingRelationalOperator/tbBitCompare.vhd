library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbBitCompare is
end entity tbBitCompare;

architecture Bhv of tbBitCompare is	
	constant cWaitTime : time := 5 ns;
	
	signal iA, iB, oEqNew, oEqOld, onEqNew, onEqOld : std_ulogic := '0';
begin
	UUT_new: entity work.bitcomparer(RTL_new)
		port map(
			iA        => iA,
			iB        => iB,
			oEqual    => oEqNew,
			oNotEqual => onEqNew
		);
	
	UUT_old: entity work.bitcomparer(RTL_old)
		port map(
			iA        => iA,
			iB        => iB,
			oEqual    => oEqOld,
			oNotEqual => onEqOld
		);
	
	Stimul : process is
	begin
		iA <= '1';
		wait for cWaitTime;
				
		assert oEqNew = '0' severity failure;
		assert onEqNew = '1';
		
		iB <= '1';
		
		wait for cWaitTime;
		
		assert oEqNew = '1' severity failure;
		assert onEqNew = '0';
		
		report "Testbench finished" severity note;
		
		finish;
	end process;
	
	assert oEqNew = oEqOld severity failure;
	assert onEqNew = onEqOld severity failure;
			
end architecture Bhv;
