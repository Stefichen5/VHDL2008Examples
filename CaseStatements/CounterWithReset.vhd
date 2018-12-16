library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CounterWithReset is
	generic (gWidth : natural := 16);
	port(
		iClk : in std_ulogic;
		inRstAsync : in std_ulogic;
		iCtrl : in std_ulogic_vector (2 downto 0);
		oData : out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity CounterWithReset;

architecture RTL of CounterWithReset is
	signal CountState, CountStateNext : std_ulogic_vector(oData'RANGE);
	signal Ctrl : std_ulogic_vector(iCtrl'RANGE);
begin
	count : process (iClk, inRstAsync) is
	begin
		if inRstAsync = '0' then
			CountState <= (others=>'0');
			Ctrl <= (others => '0');
		elsif rising_edge(iClk) then
			CountState <= CountStateNext;
			Ctrl <= iCtrl;
		end if;
	end process;
	
	counter : process(Ctrl, CountState) is
	begin
		CountStateNext <= CountState;
		--our counter has 3 control bits
		--the first(left) bit is enable
		--the other two bits control the mode
		case? ctrl is
			when "0--" => --enable bit is not set. we don't count
			when "100" => CountStateNext <= std_ulogic_vector(unsigned(CountState) + to_unsigned(1,CountState'LENGTH)); --count up
			when "101" => CountStateNext <= std_ulogic_vector(unsigned(CountState) + to_unsigned(2,CountState'LENGTH));--count up 2
			when "110" => CountStateNext <= std_ulogic_vector(unsigned(CountState) - to_unsigned(1,CountState'LENGTH));--count down
			when "111" => CountStateNext <= std_ulogic_vector(unsigned(CountState) - to_unsigned(2,CountState'LENGTH));--count down 2
			when others => CountStateNext <= (others=>'X');
		end case?;
	end process;
	
	oData <= CountState;
end architecture RTL;
