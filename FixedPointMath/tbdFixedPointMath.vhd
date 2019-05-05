library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.fixed_pkg.all;
use IEEE.float_pkg.all;

entity tbdFixedPointMath is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdFixedPointMath;

architecture RTL of tbdFixedPointMath is
	signal iA, iB, oRes : sfixed(4 downto -2);
	signal iA_float, iB_float: float(5 downto -10);
begin
	DUT_fix : entity work.FixedPointCalculator
		port map(
			iA   => iA,
			iB   => iB,
			oRes => oRes
		);
		
	DUT_float : entity work.FloatPointCalculator
		port map(
			iA   => iA_float,
			iB   => iB_float,
			oRes => open
		);
		
	iA <= to_sfixed(SW(9 downto 3),iA);
	iB <= to_sfixed(SW(6 downto 0),iB);
	LEDR(9 downto 3) <= to_std_ulogic_vector(oRes);
	
	iA_float <= to_float(12.34, iA_float);
	iB_float <= to_float(45.67, iB_float);
end architecture RTL;
