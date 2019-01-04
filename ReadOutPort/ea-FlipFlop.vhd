library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FlipFlop is
	port(
		iClk : in std_ulogic;
		inRstAsync : in std_ulogic;
		
		iD : in std_ulogic;
		oQ : out std_ulogic;
		onQ: out std_ulogic
	);
end entity FlipFlop;

architecture RTL of FlipFlop is
	
begin
	process (iClk, inRstAsync) is
	begin
		if(inRstAsync = '0') then
			oQ <= '0';
		elsif (rising_edge(iClk)) then
			oQ <= iD;
		end if;
	end process;
	
	--prior versions of VHDL do not allow reading from the output-port
	onQ <= NOT oQ;
end architecture RTL;
