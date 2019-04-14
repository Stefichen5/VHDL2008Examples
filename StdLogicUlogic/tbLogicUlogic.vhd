library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbLogicUlogic is
end entity tbLogicUlogic;

architecture Bhv of tbLogicUlogic is
	constant cClkTime : time := 5 ns;
	
	signal iClk, inResAsync : std_ulogic := '0';
	signal avs_s0_write, avs_s0_read : std_logic := '0';
	signal avs_s0_address, avs_s0_writedata, avs_s0_readdata : std_logic_vector(7 downto 0);
begin
	UUT: entity work.RegisterSet
	port map(
		csi_clk => iClk,
		rsi_reset_n  => inResAsync,
		
		avs_s0_address    => avs_s0_address,
	    avs_s0_write      => avs_s0_write,
   		avs_s0_writedata  => avs_s0_writedata,
    	avs_s0_read       => avs_s0_read,
    	avs_s0_readdata   => avs_s0_readdata
	);
		
	Stimul : process is
	begin
		avs_s0_address  <= (others => '0');
		wait for 3*cClkTime;

		inResAsync <= '1';
		avs_s0_writedata <= "11001100";
		avs_s0_write  <= '1';
		wait until rising_edge(iClk);
		
		avs_s0_write <= '0';
		avs_s0_read <= '1';
		
		wait until avs_s0_readdata'EVENT;
		assert avs_s0_readdata = "11001100" report "Unexpected result" severity failure;
		
		finish;
	end process;

	ClkGen: process is
	begin
		iClk <= NOT iClk;
		wait for cClkTime;
	end process;
end architecture Bhv;
