library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdAdder is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		BTN : in std_ulogic_vector(3 downto 0);

		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdAdder;

architecture RTL of tbdAdder is
	signal oRes : integer;
begin
	UUT : entity work.InstanceOfAdder
		generic map(
			gWidth => 5
		)
		port map(
			iA      => SW(9 downto 5),
			iB      => SW(4 downto 0),
			iAReady => BTN(3),
			iBReady => BTN(2),
			oRes    => oRes
		);
		
		LEDR <= std_ulogic_vector(to_unsigned(oRes,LEDR'LENGTH));
end architecture RTL;
