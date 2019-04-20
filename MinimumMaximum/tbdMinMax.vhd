library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdMinMax is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdMinMax;

architecture RTL of tbdMinMax is
	
begin
	DUTMin : entity work.MinMaxFinder(Min)
		generic map(gWidth => 5)
		port map(
			iA   => SW(4 downto 0),
			iB   => SW(9 downto 5),
			oRes => LEDR(4 downto 0)
		);
		
	DUTMax : entity work.MinMaxFinder(Max)
		generic map(gWidth => 5)
		port map(
			iA   => SW(4 downto 0),
			iB   => SW(9 downto 5),
			oRes => LEDR(9 downto 5)
		);
end architecture RTL;
