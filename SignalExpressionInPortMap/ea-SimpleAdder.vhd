library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SimpleAdder is
	port(
		iEn : in std_ulogic;

		iA : in integer;
		iB : in integer;
		
		oRes: out integer
	);
end entity SimpleAdder;

architecture RTL of SimpleAdder is	
begin
	oRes <= iA + iB when iEN else 0;
end architecture RTL;
