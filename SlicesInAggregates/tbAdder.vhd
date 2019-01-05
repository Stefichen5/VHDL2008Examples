library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbAdder is
end entity tbAdder;

architecture Bhv of tbAdder is
	constant cWaitTime : time := 5 ns;
	constant cWidth : natural := 8;
	
	signal iA, iB : std_ulogic_vector(cWidth-1 downto 0);
	signal oRes : std_ulogic_vector(cWidth-1 downto 0);
	signal oCarry : std_ulogic;
	
	signal SideA, SideB, Result : integer := 0;
begin
	UUT: entity work.Adder
		generic map(
			gWidth => cWidth
		)
		port map(
			iA     => iA,
			iB     => iB,
			oCarry => oCarry,
			oRes   => oRes
		);
	
	Stimul : process is
	begin
		SideA <= 50;
		SideB <= 100;
		
		wait for cWaitTime;
		
		assert Result = SideA + SideB report "Wrong adder result" severity failure;
		assert NOT oCarry report "Wrong carry" severity failure;
		
		SideA <= 255;
		SideB <= 1;
		
		wait for cWaitTime;
		
		assert Result = 0 report "Wrong adder result" severity failure;
		assert oCarry report "Wrong carry" severity failure;
		
		finish;
	end process;
	
		iA <= std_ulogic_vector(to_unsigned(SideA,iA'LENGTH));
		iB <= std_ulogic_vector(to_unsigned(SideB,iB'LENGTH));
		Result <= to_integer(unsigned(oRes));
		
end architecture Bhv;
