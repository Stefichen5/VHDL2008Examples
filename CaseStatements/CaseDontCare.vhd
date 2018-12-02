library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CaseDontCare is
	port(
		iData : in std_ulogic_vector(3 downto 0);
		oData : out std_ulogic_vector(7 downto 0)
	);
end entity CaseDontCare;

architecture RTL of CaseDontCare is
begin
	DontCare : process (iData) is
	begin
		--For this example we say that the bits 2 downto 1 must always be 0
		--if not, we produce an error (vector=0 is taken as an error)
		--if yes, then we give out bit-patterns
		case? iData is
			when "-10-" => oData <= (others=>'0');
			when "-01-" => oData <= (others=>'0');
			when "-11-" => oData <= (others=>'0');
				
			when "0001" => oData <= "10101010";
			when "1000" => oData <= "01010101";
			when "0000" => oData <= "11001100";
			when "1001" => oData <= "00110011";
			when others => oData <= (others =>'X');
		end case?;
	end process;
end architecture RTL;