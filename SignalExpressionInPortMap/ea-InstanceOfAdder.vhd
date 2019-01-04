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
		
		oRes : out integer
	);
end entity InstanceOfAdder;

architecture RTL of InstanceOfAdder is
	
begin
	Adder : entity work.SimpleAdder
		port map(
			iEn  => iAReady AND iBReady,
			iA   => to_integer(unsigned(iA)),
			iB   => to_integer(unsigned(iB)),
			oRes => oRes
		);

end architecture RTL;
