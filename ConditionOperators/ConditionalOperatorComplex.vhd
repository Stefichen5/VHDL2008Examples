library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ConditionalOperatorComplex is
	port(
		iA : in std_ulogic;
		iB : in std_ulogic;
		iC : in std_ulogic;
		iD : in std_ulogic;
		oA : out std_ulogic
	);
end entity ConditionalOperatorComplex;

architecture Example1 of ConditionalOperatorComplex is	
begin
	DoMagic : process (iA, iB, iC, iD) is
	begin
		oA <= iA AND ((iB OR iC) XOR (NOT iD));
	end process;

end architecture Example1;

architecture Example2 of ConditionalOperatorComplex is	
begin
	DoMagic : process (iA, iB, iC, iD) is
	begin
		--don't mix and match
		-- if iA AND (iB OR iC) = '1' AND iD --not allowed
		--use either
--		if (iA = '1' AND (iB OR iC) = '1' AND iD = '1') then
		--or
		if (iA AND (iB OR iC) AND iD) then
			oA <= '1';
		else
			oA <= '0';
		end if;
	end process;

end architecture Example2;