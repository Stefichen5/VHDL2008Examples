library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbShifter is
end entity tbShifter;

architecture Bhv of tbShifter is
	constant cClkTime : time := 5 ns;
	
	signal iA, oShiftLeft, oShiftRight : unsigned(7 downto 0) := "00000001";
begin
	UUT: entity work.UnsignedShifter
		port map(
			iA          => iA,
			oShiftLeft  => oShiftLeft,
			oShiftRight => oShiftRight
		);
	
	Stimul : process is
	begin
		wait for cClkTime;
		assert oShiftLeft = "00000010" severity failure;
		assert oShiftRight = "00000000" severity failure;
		
		iA <= "10000000";
		wait until oShiftLeft'EVENT;
		wait for cClkTime;
		
		assert oShiftLeft = "00000000" severity failure;
		assert oShiftRight = "01000000" severity failure;
		
		report "testbench finished" severity note;
		finish;
	end process;
end architecture Bhv;
