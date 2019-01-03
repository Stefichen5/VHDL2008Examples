library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbWordRotate is
end entity tbWordRotate;

architecture Bhv of tbWordRotate is
	constant cWaitTime : time := 5 ns;
	
	constant cWordLen : natural := 4;
	constant cNrWords : natural := 4;
	
	constant cWidth : natural := (cWordLen * cNrWords);
	
	signal iWord, oWord : std_ulogic_vector(cWidth-1 downto 0);
begin
	UUT : entity work.WordRotate
		generic map(
			gWordLen => cWordLen,
			gNrWords => cNrWords
		)
		port map(
			iWord => iWord,
			oWord => oWord
		);
		
	Stimul : process is
	begin
		iWord <= (others => '0');
		wait for cWaitTime;
		
		assert oWord = iWord report "Rotation went wrong" severity failure;
		
		iWord <= (others => '1');
		wait for cWaitTime;
		
		assert oWord = iWord report "Rotation went wrong" severity failure;
		
		
		iWord <= "1111000011110000";
		wait for cWaitTime;
		
		assert oWord = "0000111100001111" report "Rotation went wrong" severity failure;
		
		iWord <= "0000000011110000";
		wait for cWaitTime;
		
		assert oWord = "0000111100000000" report "Rotation went wrong" severity failure;
		
		report "testbench finished" severity note;
		finish;
	end process;
end architecture Bhv;
