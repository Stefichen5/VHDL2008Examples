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
	constant cWidth : natural := 5;
	signal oRes : std_ulogic_vector(cWidth downto 0);
begin
	UUT : entity work.InstanceOfAdder(RTL)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA      => SW(9 downto 5),
			iB      => SW(4 downto 0),
			iAReady => BTN(3),
			iBReady => BTN(2),
			oRes    => LEDR(oRes'RANGE)
		);
		
end architecture RTL;
