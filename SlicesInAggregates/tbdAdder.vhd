library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdAdder is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdAdder;

architecture RTL of tbdAdder is
	
begin
	UUT : entity work.Adder
		generic map(
			gWidth => 5
		)
		port map(
			iA     => SW(4 downto 0),
			iB     => SW(9 downto 5),
			oCarry => LEDR(9),
			oRes   => LEDR(8 downto 4)
		);
end architecture RTL;
