library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.PackGenericFunctions.all;

entity tbdFuncApplier is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdFuncApplier;

architecture RTL of tbdFuncApplier is
	signal iDataA, iDataB, oData : natural;
begin
	DUT_Natural : entity work.FunctionApplier
		generic map(
			gaType => natural,
			my_generic_function => natural_plus
		)
		port map(
			iDataA => iDataA,
			iDataB => iDataB,
			oData  => oData
		);
	
	DUT_Ulogic: entity work.FunctionApplier
		generic map(
			gaType => std_ulogic,
			my_generic_function => std_ulogic_and
		)
		port map(
			iDataA => SW(0),
			iDataB => SW(1),
			oData  => LEDR(0)
		);
		
		iDataA <= to_integer(unsigned(SW(3 downto 0)));
		iDataB <= to_integer(unsigned(SW(7 downto 4)));
		LEDR(9 downto 1) <= std_ulogic_vector(to_unsigned(oData,9));
end architecture RTL;
