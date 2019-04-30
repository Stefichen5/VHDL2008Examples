library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbRegisterSet is
end entity tbRegisterSet;

architecture Bhv of tbRegisterSet is
	constant cClkTime : time := 5 ns;
	constant cNrOfRegisters : natural := 4;
	constant cRegisterLength: natural := 8;
	
	signal iWrEn : std_ulogic := '0';
	signal iAddr : natural := 0;
	signal iData, oData : std_ulogic_vector(cRegisterLength-1 downto 0);	
	signal iClk, inResAsync : std_ulogic := '0';
begin
	UUT: entity work.RegisterSet
		generic map(
			gNrOfRegisters  => cNrOfRegisters,
			gRegisterLength => cRegisterLength
		)
		port map(
			iClk       => iClk,
			inResAsync => inResAsync,
			iAddr      => iAddr,
			iData      => iData,
			iWrEn      => iWrEn,
			oData      => oData
		);
	
	Stimul : process is
	begin
		iWrEn <= '0';
		iAddr <= 0;
		iData <= (others => '0');
		wait for cClkTime*2;
		
		inResAsync <= '1';
		iWrEn <= '1';
		iData <= "11001100";
		
		wait until oData'EVENT;
		
		assert oData = "11001100" severity failure;
		
		iWrEn <= '0';
		iData <= "00000000";
		wait for 2*cClkTime;
		
		assert oData = "11001100" severity failure;
		
		report "simulation finished" severity note;
		
		finish;
	end process;

	ClkGen: process is
	begin
		iClk <= NOT iClk;
		wait for cClkTime;
	end process;
end architecture Bhv;
