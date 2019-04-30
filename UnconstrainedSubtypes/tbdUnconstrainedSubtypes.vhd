library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdUnconstrainedSubtypes is
	port(
		CLOCK_50 : in std_ulogic;
		SW : in std_ulogic_vector(9 downto 0);
		BTN: in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdUnconstrainedSubtypes;

architecture RTL of tbdUnconstrainedSubtypes is
	constant cNrOfRegisters : natural := 4;
	constant cRegisterLength: natural := 8;
begin
	DUT: entity work.RegisterSet
		generic map(
			gNrOfRegisters  => cNrOfRegisters,
			gRegisterLength => cRegisterLength
		)
		port map(
			iClk       => CLOCK_50,
			inResAsync => SW(9),
			iAddr      => to_integer(unsigned(SW(7 downto 0))),
			iData      => BTN(7 downto 0),
			iWrEn      => SW(8),
			oData      => LEDR(7 downto 0)
		);	
end architecture RTL;
