library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbCaseDontCare is
end entity tbCaseDontCare;

architecture Bhv of tbCaseDontCare is
	signal iData : std_ulogic_vector(3 downto 0);
	signal oData : std_ulogic_vector(7 downto 0);
begin
	uut : entity work.CaseDontCare
		port map(
			iData => iData,
			oData => oData
		);
		
	stimul : process is
		variable vTmp : std_ulogic_vector (3 downto 0) := (others=>'X');
	begin
		iData <= (others=>'0');
		wait for 5 ns;
		
		for i in 0 to 15 loop
			iData <= std_ulogic_vector(to_unsigned(i,iData'LENGTH));
			wait for 5 ns;
			
			vTmp := std_ulogic_vector(to_unsigned(i,iData'LENGTH));
			
			if vTmp(2 downto 1) /= "00" then
				assert oData = "00000000" report "oData must be 0" severity failure;		
			else
				assert oData /= "00000000" report "oData must not be 0" severity failure;	
			end if;
		end loop;
		
		wait;
	end process;
end architecture Bhv;
