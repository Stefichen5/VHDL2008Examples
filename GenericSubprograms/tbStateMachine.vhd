library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbStateMachine is
end entity tbStateMachine;

architecture Bhv of tbStateMachine is
	constant cClkTime : time := 5 ns;
	constant cWaitTime : time := 2 * cClkTime;

	signal iClk, inResAsync : std_ulogic := '0';	
	signal iData, oData : std_ulogic_vector(9 downto 0);
	signal iCtrl : std_ulogic_vector(2 downto 0);
begin
	UUT: entity work.StateMachine
		port map(
			iClk       => iClk,
			inResAsync => inResAsync,
			iData      => iData,
			iCtrl      => iCtrl,
			oData      => oData
		);
		
	Stimul : process is
	begin
		iData <= "1100110011";
		iCtrl <= (others => '0');
		wait for cWaitTime;
		
		inResAsync <= '1';
		
		wait until oData'EVENT;
		assert oData = std_ulogic_vector(shift_left(unsigned(iData), 1))report "Unexpected result" severity failure;
		
		iCtrl <= "001";
		
		wait until oData'EVENT;
		assert oData = std_ulogic_vector(shift_right(unsigned(iData), 2))report "Unexpected result" severity failure;
		
		iCtrl <= "010";
		
		wait until oData'EVENT;
		assert oData = std_ulogic_vector(shift_left(unsigned(iData), 3))report "Unexpected result" severity failure;
		
		iCtrl <= "100";
		
		wait until oData'EVENT;
		assert oData = std_ulogic_vector(shift_left(unsigned(iData), 1))report "Unexpected result" severity failure;
		
		finish;
	end process;
	
	ClkGen : process is
	begin
		iClk <= NOT iClk;
		wait for cClkTime;
	end process;
end architecture Bhv;
