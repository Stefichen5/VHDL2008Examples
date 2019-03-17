library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdUnconstrainedMatrix is
	port(
		iClk : in std_ulogic;
		inResAsync : in std_ulogic;
		
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdUnconstrainedMatrix;

architecture RTL of tbdUnconstrainedMatrix is
	constant cNrCols, cNrRows : natural := 4;
begin
	UUT: entity work.UnconstrainedMatrix
		generic map(
			gNrCols => cNrCols,
			gNrRows => cNrRows
		)
		port map(
			iClk       => iClk,
			inResAsync => inResAsync,
			iSelRow    => to_integer(unsigned(SW(1 downto 0))),
			iSelCol    => to_integer(unsigned(SW(3 downto 2))),
			iWrEn      => SW(4),
			iBit       => SW(5),
			oBit       => LEDR(0)
		);	
		
		LEDR(9 downto 1) <= (others => '0');
end architecture RTL;
