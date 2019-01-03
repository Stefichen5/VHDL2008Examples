library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdWordRotate is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdWordRotate;

architecture RTL of tbdWordRotate is
	
begin
	UUT: entity work.WordRotate
		generic map(
			gWordLen => 2,
			gNrWords => 5
		)
		port map(
			iWord => SW,
			oWord => LEDR
		);
end architecture RTL;
