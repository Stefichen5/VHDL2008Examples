library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FlipFlop is
	generic (gWidth : natural := 1);
	port(
		iClk : in std_ulogic;
		inRstAsync : in std_ulogic;
		iD : in std_ulogic_vector(gWidth-1 downto 0);
		oQ : out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity FlipFlop;

architecture RTL of FlipFlop is
begin
	FF: process (iClk, inRstAsync) is
	begin
		if(inRstAsync=NOT('1')) then
			oQ <= (others=>'0');
		elsif (rising_edge(iClk)) then
			oQ <= iD;
		end if;
	end process;

end architecture RTL;
