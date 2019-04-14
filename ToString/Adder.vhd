library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
	port(
		iA : in natural;
		iB : in natural;
		oRes : out natural
	);
end entity Adder;

architecture RTL of Adder is
	
begin
	process (all) is
	begin
		oRes <= iA + iB;
	end process;
end architecture RTL;
