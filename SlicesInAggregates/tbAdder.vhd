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
	signal oRes, oResOld : std_ulogic_vector(cWidth-1 downto 0);
	signal oCarry, oCarryOld : std_ulogic;
	
	signal SideA, SideB, Result, ResultOld : integer := 0;
begin
	UUT: entity work.Adder(RTL)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA     => iA,
			iB     => iB,
			oCarry => oCarry,
			oRes   => oRes
		);
		
	UUT_old: entity work.Adder(RTL_old)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA     => iA,
			iB     => iB,
			oCarry => oCarryOld,
			oRes   => oResOld
		);
	
	Stimul : process is
	begin
		SideA <= 50;
		SideB <= 100;
		
		wait for cWaitTime;
		
		assert Result = SideA + SideB report "Wrong adder result" severity failure;
		assert Result = ResultOld report "old and new implementation differ" severity failure;
		
		assert oCarry='0' report "Wrong carry" severity failure;
		assert oCarry = oCarryOld report "old and new implementation differ" severity failure;
		
		SideA <= 255;
		SideB <= 1;
		
		wait for cWaitTime;
		
		assert Result = 0 report "Wrong adder result" severity failure;
		assert Result = ResultOld report "old and new implementation differ" severity failure;
		
		assert oCarry='1' report "Wrong carry" severity failure;
		assert oCarry = oCarryOld report "old and new implementation differ" severity failure;
		
		finish;
	end process;
	
		iA <= std_ulogic_vector(to_unsigned(SideA,iA'LENGTH));
		iB <= std_ulogic_vector(to_unsigned(SideB,iB'LENGTH));
		Result <= to_integer(unsigned(oRes));
		ResultOld <= to_integer(unsigned(oResOld));
		
end architecture Bhv;
