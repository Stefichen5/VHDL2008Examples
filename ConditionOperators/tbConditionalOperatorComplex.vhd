library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbConditionalOperatorComplex is
end entity tbConditionalOperatorComplex;

architecture RTL of tbConditionalOperatorComplex is
	signal iA,iB,iC,iD,oA1, oA2 : std_ulogic;
begin
	UUT_Example1 : entity work.ConditionalOperatorComplex(Example1)
		port map(
			iA => iA,
			iB => iB,
			iC => iC,
			iD => iD,
			oA => oA1
		);
		
	UUT_Example2 : entity work.ConditionalOperatorComplex(Example2)
		port map(
			iA => iA,
			iB => iB,
			iC => iC,
			iD => iD,
			oA => oA2
		);
		
	stimul: process is
	begin
		iA<='0';
		iB<='0';
		iC<='0';
		iD<='0';
		
		wait for 5 ns;
	end process;
end architecture RTL;
