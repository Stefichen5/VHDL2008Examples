library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbVectorJoiner is
end entity tbVectorJoiner;

architecture Bhv of tbVectorJoiner is
	constant cWaitTime : time := 5 ns;
	constant cWidth  : natural := 4;
	
	signal iA, iB : std_ulogic_vector(cWidth-1 downto 0);
	signal oRes : std_ulogic_vector(2*cWidth-1 downto 0);
	signal inReset : std_ulogic := '0';
begin
	UUT: entity work.VectorJoiner
		generic map(
			gInLength  => cWidth
		)
		port map(
			iA  => iA,
			iB  => iB,
			inReset => inReset,
			oAB => oRes
		);
	
	Stimul : process is
	begin
		iA <= (others => '0');
		iB <= (others => '0');
		
		wait for cWaitTime;
		
		assert oRes = "00000000" report "wrong result" severity failure;
		
		iA <= (others => '1');
		
		wait for cWaitTime;
		
		assert oRes = "00000000" report "wrong result" severity failure;
		inReset <= '1';
		
		wait until oRes'EVENT;
		
		assert oRes = "11110000" report "wrong result" severity failure;
		
		report "Testbench finished" severity note;
		
		finish;
	end process;
end architecture Bhv;
