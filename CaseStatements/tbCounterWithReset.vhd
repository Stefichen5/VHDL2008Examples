library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tbCounterWithReset is
end entity tbCounterWithReset;

architecture Bhv of tbCounterWithReset is
	constant cWidth : natural := 8;
	signal iClk, inRstAsync : std_ulogic := '0';
	signal iCtrl : std_ulogic_vector(2 downto 0);
	signal oData : std_ulogic_vector(cWidth-1 downto 0);
begin
	uut : entity work.CounterWithReset
		generic map (gWidth => cWidth)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iCtrl      => iCtrl,
			oData      => oData
		);

	stimul : process is
	begin
		iCtrl <= "000";
		wait for 10 ns;
		
		inRstAsync <= '1';
		
		--wait for a few clock cycles
		for i in 0 to 4 loop
			wait until iClk;
		end loop;
		
		assert oData = std_ulogic_vector(to_unsigned(0,oData'LENGTH)) report "Counter should not yet count because start-bit is not set" severity failure;

		iCtrl <= "100";
		--wait for a few clock cycles
		for i in 0 to 4 loop
			wait until oData'EVENT;
		end loop;

		assert oData = std_ulogic_vector(to_unsigned(5,oData'LENGTH)) report "Counter should have counted to 5 by now" severity failure;

		iCtrl <= "000";

		--wait for a few clock cycles
		for i in 0 to 5 loop
			wait until iClk;
		end loop;

		--will still count to 6 because the iCtrl <= '000' still takes a clock cycle to get recognized
		--and in that cycle, the counter stil counts
		assert oData = std_ulogic_vector(to_unsigned(6,oData'LENGTH)) report "Counter should not have counted further up" severity failure;
		
		/* RESET AND START AGAIN */
		iCtrl <= "000";
		
		inRstAsync <= '0';
		wait until iClk;
		
		inRstAsync <= '1';
		wait until iClk;

		iCtrl <= "101";
		
		--wait for a few clock cycles
		for i in 0 to 4 loop
			wait until oData'EVENT;
		end loop;

		assert oData = std_ulogic_vector(to_unsigned(10,oData'LENGTH)) report "Counter should have counted until 10 by now" severity failure;

		/* RESET AND START AGAIN */
		iCtrl <= "000";
		
		inRstAsync <= '0';
		wait until iClk;
		
		inRstAsync <= '1';
		wait until iClk;

		iCtrl <= "110";
		
		--wait for a few clock cycles
		for i in 0 to 5 loop
			wait until oData'EVENT;
		end loop;

		assert oData = std_ulogic_vector(to_unsigned(250,oData'LENGTH)) report "Counter should have counted down to 250 by now" severity failure;


		/* RESET AND START AGAIN */
		iCtrl <= "000";
		
		inRstAsync <= '0';
		wait until iClk;
		
		inRstAsync <= '1';
		wait until iClk;

		iCtrl <= "111";
		
		--wait for a few clock cycles
		for i in 0 to 5 loop
			wait until oData'EVENT;
		end loop;
		
		assert oData = std_ulogic_vector(to_unsigned(244,oData'LENGTH)) report "Counter should have counted down to 244 by now" severity failure;

		iCtrl <= "000";
		--wait for a few clock cycles
		for i in 0 to 5 loop
			wait until iClk;
		end loop;
		
		report "Testbench for CounterWithReset finished successfully." severity note;
		stop;
		wait;
	end process;

	ClkGen : process is
	begin
		iClk <= NOT iClk;
		wait for 5 ns;
	end process;
end architecture Bhv;
