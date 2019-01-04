library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tbFFSynchronizer is
end entity tbFFSynchronizer;

architecture Bhv of tbFFSynchronizer is
	constant cWidth : natural := 1;
	signal iClk, inRstAsync : std_ulogic := '0';
	signal iD,MaybeMeta,Synced : std_ulogic_vector(cWidth-1 downto 0);
begin
	FF1 : entity work.FlipFlop
		generic map(
			gWidth => cWidth
		)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => iD,
			oQ         => MaybeMeta
		);
		
	FF2: entity work.FlipFlop
		generic map(
			gWidth => cWidth
		)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => MaybeMeta,
			oQ         => Synced
		);
		
	stimul : process is
	begin
		inRstAsync <= '0';
		iD <= (others=>'1');
		wait for 7 ns;
		assert Synced="0" report "Output should be 0" severity failure;
		
		inRstAsync <= '1';
		wait for 5 ns;
		assert Synced="0" report "Output should be 0" severity failure;
		
		wait for 10 ns;
		assert iD=Synced report "Input not corretly passed through" severity failure;
		
		--now we force a signal
		MaybeMeta <= force "X";
		wait for 10 ns;
		assert Synced="X" report "Force X did not succeed" severity failure;
		
		--Release the force and let the FFs recover
		MaybeMeta <= release;
		wait for 15 ns;
		assert iD=Synced report "Input not corretly passed through" severity failure;

		wait for 10 ns;
		
		--no more changes
		--halt simulation here
		--if we would not use "stop", then the clock generator would keep the simulation going
		stop;
		wait;
	end process;
		
	ClkGen : process is
	begin
		iClk <= NOT iClk;
		wait for 5 ns;
	end process;
end architecture Bhv;
