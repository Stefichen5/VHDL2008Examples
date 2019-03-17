--base example taken from VHDL-2008 Just the new stuff
--but modified for my usecase

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
	generic (gWidth : natural);
	port(
		iA : in std_ulogic_vector(gWidth-1 downto 0);
		iB : in std_ulogic_vector(gWidth-1 downto 0);
		
		oCarry: out std_ulogic;
		oRes : out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity Adder;

architecture RTL of Adder is
begin
	(oCarry, oRes) <= std_ulogic_vector(unsigned('0' & iA) + unsigned('0' & iB));	
end architecture RTL;

-- PRE-VHDL-2008
architecture RTL_old of Adder is
	signal result : std_ulogic_vector(gWidth downto 0);
begin
	result <= std_ulogic_vector(unsigned('0' & iA) + unsigned('0' & iB));
	
	oRes <= result (result'LEFT-1 downto 0);
	oCarry <= result(result'LEFT);
end architecture;