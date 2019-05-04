library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnsignedShifter is
	port(
		iA : in unsigned(7 downto 0);
		oShiftLeft : out unsigned(7 downto 0);
		oShiftRight: out unsigned(7 downto 0)
	);
end entity UnsignedShifter;

architecture RTL of UnsignedShifter is
	
begin
	oShiftLeft <= iA sla 1;
	oShiftRight <= iA sra 1;
end architecture RTL;
