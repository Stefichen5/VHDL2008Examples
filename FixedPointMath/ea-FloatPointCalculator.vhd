library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;

entity FloatPointCalculator is
	port(
		iA : in float(4 downto -2);
		iB : in float(4 downto -2);
		oRes: out float(4 downto -2)
	);
end entity FloatPointCalculator;

architecture RTL of FloatPointCalculator is
begin
	oRes <= iA + iB;
end architecture RTL;
