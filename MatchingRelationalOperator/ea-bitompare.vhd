library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bitcomparer is
	port(
		iA : in std_ulogic;
		iB : in std_ulogic;
		oEqual: out std_ulogic;
		oNotEqual: out std_ulogic
	);
end entity bitcomparer;

architecture RTL_new of bitcomparer is	
begin
	oEqual <= iA ?= iB;
	oNotEqual <= iA ?/= iB;
end architecture RTL_new;

architecture RTL_old of bitcomparer is
begin
	oEqual <= '1' when iA = iB else '0';
	oNotEqual <= '1' when iA /= iB else '0';
end architecture;