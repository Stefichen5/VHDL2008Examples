library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdConditionalOperator is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdConditionalOperator;

architecture RTL of tbdConditionalOperator is
	constant cWidth : natural := 1;
begin
	UUT_muxOld : entity work.ConditionalOperatorMux(Multiplexer_Old)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA(0)    => SW(0),
			iB(0)    => SW(1),
			iCtrl => SW(9),
			oRes(0)  => LEDR(0)
		);
		
	UUT_muxNew : entity work.ConditionalOperatorMux(Multiplexer_New)
		generic map(
		gWidth => cWidth
		)
		port map(
			iA(0)    => SW(0),
			iB(0)    => SW(1),
			iCtrl => SW(9),
			oRes(0)  => LEDR(1)
		);
end architecture RTL;
