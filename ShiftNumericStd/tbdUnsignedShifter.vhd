library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdUnsignedShifter is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdUnsignedShifter;

architecture RTL of tbdUnsignedShifter is
	signal SW_to_iA : unsigned(7 downto 0);
	signal oShift_to_LEDR : unsigned(7 downto 0);
begin
	DUT: entity work.UnsignedShifter
		port map(
			iA          => SW_to_iA,
			oShiftLeft  => oShift_to_LEDR,
			oShiftRight => open
		);
		
		SW_to_iA <= unsigned(SW(7 downto 0));
		LEDR(7 downto 0) <= std_ulogic_vector(oShift_to_LEDR);
end architecture RTL;
