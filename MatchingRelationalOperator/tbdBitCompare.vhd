library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdBitCompare is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdBitCompare;

architecture RTL of tbdBitCompare is
begin
	UUT_new: entity work.bitcomparer
		port map(
			iA        => SW(0),
			iB        => SW(1),
			oEqual    => LEDR(0),
			oNotEqual => LEDR(1)
		);
		
	UUT_old: entity work.bitcomparer
		port map(
			iA        => SW(0),
			iB        => SW(1),
			oEqual    => LEDR(2),
			oNotEqual => LEDR(3)
		);
end architecture RTL;
