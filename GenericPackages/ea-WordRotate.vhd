library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WordRotate is
	generic(gWordLen : natural;
		gNrWords : natural
	);
	port(
		iWord : in std_ulogic_vector((gWordLen * gNrWords) - 1 downto 0);
		oWord : out std_ulogic_vector((gWordLen * gNrWords) - 1 downto 0)
	);
end entity WordRotate;

architecture RTL of WordRotate is
	package pWordRotate is new work.packWordRotate
		generic map(gWordLen => gWordLen,
				gNrWords => gNrWords
	);	
	use pWordRotate.all;
begin
	oWord <= RotateLeft(iWord);
end architecture RTL;
