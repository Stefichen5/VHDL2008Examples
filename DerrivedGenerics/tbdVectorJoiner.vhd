library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdVectorJoiner is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdVectorJoiner;

architecture RTL of tbdVectorJoiner is
begin
	DUT : entity work.VectorJoiner
		generic map(
			gInLength  => 5
		)
		port map(
			inReset => '1',
			iA      => SW(4 downto 0),
			iB      => SW(9 downto 5),
			oAB     => LEDR
		);
end architecture RTL;
