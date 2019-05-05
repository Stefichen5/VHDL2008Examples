library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.fixed_pkg.all;

entity FixedPointCalculator is
	port(
		iA : in sfixed(4 downto -2);
		iB : in sfixed(4 downto -2);
		oRes: out sfixed(4 downto -2)
	);
end entity FixedPointCalculator;

architecture RTL of FixedPointCalculator is
	signal ResTmp : sfixed(5 downto -2);
begin
	ResTmp <= iA + iB;
	
	oRes <= resize(arg => ResTmp,
					left_index => 4,
					right_index => -2);
end architecture RTL;
