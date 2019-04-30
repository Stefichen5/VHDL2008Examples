library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterSet is
	generic(gNrOfRegisters : natural := 16;
			gRegisterLength : natural := 8
	);
	port(
		iClk : in std_ulogic;
		inResAsync : in std_ulogic;
		
		iAddr : in natural;
		iData : in std_ulogic_vector(gRegisterLength-1 downto 0);
		iWrEn : in std_ulogic;
		
		oData : out std_ulogic_vector(gRegisterLength-1 downto 0)
	);
end entity RegisterSet;

architecture RTL of RegisterSet is
	type aRegisterSet is array (natural range<>) of std_ulogic_vector;
	
	signal RegisterSet, RegisterSetNext : aRegisterSet(gNrOfRegisters-1 downto 0)(gRegisterLength-1 downto 0);
begin
	process (iClk, inResAsync) is
	begin
		if(inResAsync = '0') then
			RegisterSet <= (others => (others=> '0'));
		elsif (rising_edge(iClk)) then
			RegisterSet <= RegisterSetNext;
		end if;
	end process;
	
	
	write: process (all) is
	begin
		RegisterSetNext <= RegisterSet;
		
		if(iWrEn = '1') then
			RegisterSetNext(iAddr) <= iData;
		end if;
		
	end process;
	
	oData <= RegisterSet(iAddr);
end architecture RTL;
