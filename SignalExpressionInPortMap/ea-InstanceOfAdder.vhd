library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstanceOfAdder is
	generic(gWidth : natural);
	port(
		iA : in std_ulogic_vector(gWidth-1 downto 0);
		iB : in std_ulogic_vector (gWidth-1 downto 0);
		
		iAReady : in std_ulogic;
		iBReady : in std_ulogic;
		
		oRes : out std_ulogic_vector(gWidth downto 0)
	);
end entity InstanceOfAdder;

architecture RTL of InstanceOfAdder is
	signal AdderOut : integer;
begin
	Adder : entity work.SimpleAdder
		port map(
			iEn  => iAReady AND iBReady,
			iA   => to_integer(unsigned(iA)),
			iB   => to_integer(unsigned(iB)),
			oRes => AdderOut
		);

	oRes <= std_ulogic_vector(to_unsigned(AdderOut,oRes'LENGTH));

end architecture RTL;

architecture RTL_old of InstanceOfAdder is
	signal AdderInA, AdderInB, AdderOut : integer;
	signal AdderEnable : std_ulogic;
begin
	Adder : entity work.SimpleAdder
		port map(
			iEn  => AdderEnable,
			iA   => AdderInA,
			iB   => AdderInB,
			oRes => AdderOut
		);
		
	AdderInA <= to_integer(unsigned(iA));
	AdderInB <= to_integer(unsigned(iB));
	AdderEnable <= iAReady AND iBReady;
	
	oRes <= std_ulogic_vector(to_unsigned(AdderOut,oRes'LENGTH));

end architecture RTL_old;