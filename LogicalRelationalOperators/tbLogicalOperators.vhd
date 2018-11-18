library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbLogicalOperators is
end entity tbLogicalOperators;

architecture Bhv of tbLogicalOperators is
	constant width : natural := 8;
	signal iData : std_ulogic_vector(width-1 downto 0);	
	signal oResult_old, oResult_new : std_ulogic;
begin
	uut_AND_Classic: entity work.LogicalOperators(AND_Classic)
		generic map (gWidth => width)
		port map(
			iData   => iData,
			oResult => oResult_old
		);
		
	uut_AND_Modern: entity work.LogicalOperators(AND_Modern)
		generic map(
			gWidth => Width
		)
		port map(
			iData   => iData,
			oResult => oResult_new
		);
		
	stimul: process is
	begin
		iData <= (others=>'0');
		wait for 5 ns;
		
		assert (oResult_old = oResult_new) AND (oResult_old = '0') report "Unexpected result" severity failure;
		
		iData(iData'LOW) <= '1';
		wait for 5 ns;

		assert (oResult_old = oResult_new) AND (oResult_old = '0') report "Unexpected result" severity failure;
		
		iData <= (others=>'1');
		wait for 5 ns;

		assert (oResult_old = oResult_new) AND (oResult_old = '1') report "Unexpected result" severity failure;
		
		report "Testbench finished successfully" severity note;
		wait;
	end process;
end architecture Bhv;
