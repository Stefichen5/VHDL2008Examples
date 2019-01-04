library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbFlipFlop is
end entity tbFlipFlop;

architecture Bhv of tbFlipFlop is
	constant cClkTime : time := 5 ns;
	
	signal iClk, inRstAsync : std_ulogic := '0';
	signal iD, oQ, onQ : std_ulogic;
begin
	UUT: entity work.FlipFlop
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => iD,
			oQ         => oQ,
			onQ        => onQ
		);	
		
	Stimul : process is
	begin
		iD <= '0';

		wait for cClkTime;
		
		assert oQ = '0' report "Output ports have wrong values" severity failure;
		assert oQ = (NOT onQ) report "Output ports have wrong values" severity failure;
		
		inRstAsync <= '1';
		
		wait for cClkTime;
		
		assert oQ = '0' report "Output ports have wrong values" severity failure;
		assert oQ = (NOT onQ) report "Output ports have wrong values" severity failure;
		
		iD <= '1';
		
		wait until oQ'EVENT;
		wait for 0 ns; --we have to wait for 1 delta since the onQ gets it's value 1 delta after oQ
		
		assert oQ = '1' report "Output ports have wrong values" severity failure;
		assert oQ = (NOT onQ) report "Output ports have wrong values" severity failure;
		
		wait for 5*cClkTime;
		
		assert oQ = '1' report "Output ports have wrong values" severity failure;
		assert oQ = (NOT onQ) report "Output ports have wrong values" severity failure;
		
		iD <= '0';
		wait until oQ'EVENT;
		wait for 0 ns; --we have to wait for 1 delta since the onQ gets it's value 1 delta after oQ
		
		assert oQ = '0' report "Output ports have wrong values" severity failure;
		assert oQ = (NOT onQ) report "Output ports have wrong values" severity failure;
		
		report "Simulation finished" severity note;
		
		finish;	
	end process;
	
	ClkGen : process is
	begin
		iClk <= NOT iCLK;
		wait for cClkTime;
	end process;
		
end architecture Bhv;
