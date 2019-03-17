library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbUnconstrainedMatrix is
end entity tbUnconstrainedMatrix;

architecture Bhv of tbUnconstrainedMatrix is
	constant cClkTime : time := 5 ns;
	
	constant cNrCols : natural := 2;
	constant cNrRows : natural := 3;
	
	signal iClk, inResAsync : std_ulogic := '0';
	
	signal iBit, oBit, iWrEn : std_ulogic := '0';
	signal iSelRow, iSelCol : natural := 0;
begin
	UUT: entity work.UnconstrainedMatrix
		generic map(
			gNrCols => cNrCols,
			gNrRows => cNrRows
		)
		port map(
			iClk       => iClk,
			inResAsync => inResAsync,
			iSelRow    => iSelRow,
			iSelCol    => iSelCol,
			iWrEn      => iWrEn,
			iBit       => iBit,
			oBit       => oBit
		);
	
	Stimul : process is
	begin
		wait for 3*cClkTime;
		inResAsync <= '1';
		
		wait for cClkTime;
		
		assert oBit = '0' report "Not 0 after reset" severity failure;
		
		-- write '1' to every bit
		for y in 0 to cNrRows-1 loop
			for x in 0 to cNrCols-1 loop
				iSelRow <= y;
				iSelCol <= x;
				iBit <= '1';
				iWrEn <= '1';
				wait until oBit;
			end loop;
		end loop;
		
		wait until iClk;
		
		iWrEn <= '0';
		
		for y in 0 to cNrRows-1 loop
			for x in 0 to cNrCols-1 loop
				iSelRow <= y;
				iSelCol <= x;

				wait for 2*cClkTime;
				
				assert oBit = '1' report "Bit did not get written" severity failure;
			end loop;
		end loop;
		
		report "testbench finished" severity note;
		
		finish;
	end process;

	ClkGen: process is
	begin
		iClk <= NOT iClk;
		wait for cClkTime;
	end process;
end architecture Bhv;
