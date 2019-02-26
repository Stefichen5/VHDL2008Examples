library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdLogicalOperators is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdLogicalOperators;

architecture RTL of tbdLogicalOperators is
	constant cWidth : natural := 10;
begin
	uut_AND_Classic: entity work.LogicalOperators(AND_Classic)
	generic map (gWidth => cWidth)
	port map(
		iData   => SW,
		oResult => LEDR(1)
	);
		
	uut_AND_Modern: entity work.LogicalOperators(AND_Modern)
		generic map(
			gWidth => cWidth
		)
		port map(
			iData   => SW,
			oResult => LEDR(0)
		);
end architecture RTL;
