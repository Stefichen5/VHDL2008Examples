library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbFlipFlop is
end entity tbFlipFlop;

architecture Bhv of tbFlipFlop is
	constant cClkTime : time := 5 ns;
	
	signal iClk, inRstAsync : std_ulogic := '0';
	signal iD, oQ_new, oQ_old, onQ_new, onQ_old : std_ulogic;
begin
	-- VHDL 2008-Style
	UUT_new: entity work.FlipFlop(RTL_new)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => iD,
			oQ         => oQ_new,
			onQ        => onQ_new
		);	
		
	-- pre-VHDL 2008
	UUT_old: entity work.FlipFlop(RTL_new)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => iD,
			oQ         => oQ_old,
			onQ        => onQ_old
		);	
		
	Stimul : process is
	begin
		iD <= '0';

		wait for cClkTime;
		
		assert (oQ_new OR oQ_old) = '0' report "Output ports have wrong values" severity failure;
		assert (oQ_new = (NOT onQ_new)) AND (oQ_old = (NOT onQ_old)) report "Output ports have wrong values" severity failure;
		
		inRstAsync <= '1';
		
		wait for cClkTime;
		
		assert (oQ_new OR oQ_old) = '0' report "Output ports have wrong values" severity failure;
		assert (oQ_new = (NOT onQ_new)) AND (oQ_old = (NOT onQ_old)) report "Output ports have wrong values" severity failure;
		
		iD <= '1';
		
		wait until oQ_old'EVENT;
		wait for 0 ns; --we have to wait for 1 delta since the onQ gets it's value 1 delta after oQ
		
		assert (oQ_new AND oQ_old) = '1' report "Output ports have wrong values" severity failure;
		assert (oQ_new = (NOT onQ_new)) AND (oQ_old = (NOT onQ_old)) report "Output ports have wrong values" severity failure;
		
		wait for 5*cClkTime;
		
		assert (oQ_new AND oQ_old) = '1' report "Output ports have wrong values" severity failure;
		assert (oQ_new = (NOT onQ_new)) AND (oQ_old = (NOT onQ_old)) report "Output ports have wrong values" severity failure;
		
		iD <= '0';
		wait until oQ_old'EVENT;
		wait for 0 ns; --we have to wait for 1 delta since the onQ gets it's value 1 delta after oQ
		
		assert (oQ_new OR oQ_old) = '0' report "Output ports have wrong values" severity failure;
		assert (oQ_new = (NOT onQ_new)) AND (oQ_old = (NOT onQ_old)) report "Output ports have wrong values" severity failure;
		
		report "Simulation finished" severity note;
		
		finish;	
	end process;
	
	ClkGen : process is
	begin
		iClk <= NOT iCLK;
		wait for cClkTime;
	end process;
		
end architecture Bhv;
